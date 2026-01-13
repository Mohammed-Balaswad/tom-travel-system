<?php

namespace App\Http\Controllers\Booking;

use App\Http\Controllers\Controller;
use App\Models\HotelBooking;
use App\Models\Room;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;


class HotelBookingController extends Controller
{
    public function index()
    {
        $bookings = HotelBooking::with(['hotel:id,name', 'room:id,type,price_per_night'])
            ->where('user_id', Auth::id())
            ->orderByDesc('created_at')
            ->get();

        return response()->json([
            'status' => true,
            'count' => $bookings->count(),
            'data' => $bookings,
        ]);
    }

    
    // إنشاء حجز جديد بعد التحقق من توفر الغرفة.   
    public function store(Request $request)
    {
        $validated = $request->validate([
            'hotel_id' => 'required|exists:hotels,id',
            'room_id' => 'required|exists:rooms,id',
            'check_in' => 'required|date|after_or_equal:today',
            'check_out' => 'required|date|after:check_in',
            'adults' => 'required|integer|min:1',
            'children' => 'nullable|integer|min:0',
            'rooms_count' => 'required|integer|min:1',
        ]);

        $room = Room::findOrFail($validated['room_id']);

        // التحقق من توفر الغرفة
        if (!$room->is_available) {
            return response()->json([
                'status' => false,
                'message' => 'Room is not available for booking.',
            ], 400);
        }

        // حساب عدد الليالي
        $checkIn = Carbon::parse($validated['check_in']);
        $checkOut = Carbon::parse($validated['check_out']);
        $nights = $checkIn->diffInDays($checkOut);

        // إجمالي الضيوف (adults + children)
        $adults = (int) $validated['adults'];
        $children = isset($validated['children']) ? (int) $validated['children'] : 0;
        $guestsTotal = $adults + $children;

        // حساب السعر الإجمالي
        $totalPrice = $room->price_per_night * $nights * $validated['rooms_count'];

        // إنشاء الحجز
        $booking = HotelBooking::create([
            'user_id' => Auth::id(),
            'hotel_id' => $validated['hotel_id'],
            'room_id' => $validated['room_id'],
            'check_in' => $validated['check_in'],
            'check_out' => $validated['check_out'],
            'nights' => $nights,
            'rooms_count' => $validated['rooms_count'],
            'adults' => $adults,
            'children' => $children,
            'guests_total' => $guestsTotal,
            'total_price' => $totalPrice,
            'status' => 'pending',
            'payment_status' => 'unpaid',
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Booking created successfully.',
            'data' => $booking,
        ], 201);
    }

    
    // عرض تفاصيل حجز معين.
    public function show($id)
    {
        $booking = HotelBooking::with(['hotel', 'room'])
            ->where('user_id', Auth::id())
            ->find($id);

        if (!$booking) {
            return response()->json([
                'status' => false,
                'message' => 'Booking not found.',
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $booking,
        ]);
    }


    //  تحديث حالة حجز.
    public function update(Request $request, $id)
    {
        $booking = HotelBooking::find($id);

        if (!$booking) {
            return response()->json([
                'status' => false,
                'message' => 'Booking not found.'
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'status' => 'in:pending,confirmed,rejected,cancelled',
            'payment_status' => 'in:unpaid,paid',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $booking->update($request->only(['status', 'payment_status']));

        return response()->json([
            'status' => true,
            'message' => 'Booking updated successfully.',
            'data' => $booking
        ]);
    }

    
    //  إلغاء حجز.     
    public function cancel($id)
    {
        $booking = HotelBooking::where('user_id', Auth::id())->find($id);

        if (!$booking) {
            return response()->json([
                'status' => false,
                'message' => 'Booking not found.',
            ], 404);
        }

        if ($booking->status === 'cancelled') {
            return response()->json([
                'status' => false,
                'message' => 'Booking already cancelled.',
            ], 400);
        }

        $booking->update(['status' => 'cancelled']);

        return response()->json([
            'status' => true,
            'message' => 'Booking cancelled successfully.',
        ]);
    }
}
