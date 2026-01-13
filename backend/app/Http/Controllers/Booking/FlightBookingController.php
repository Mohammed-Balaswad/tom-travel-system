<?php

namespace App\Http\Controllers\Booking;

use App\Http\Controllers\Controller;
use App\Models\FlightBooking;
use App\Models\Flight;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FlightBookingController extends Controller
{
     
    //  عرض جميع الحجوزات (حسب المستخدم)  
    public function index(Request $request)
    {
        $user = $request->user();

        $bookings = FlightBooking::with('flight')
            ->when($user->role === 'tourist', function ($query) use ($user) {
                $query->where('user_id', $user->id);
            })
            ->latest()
            ->get();

        return response()->json([
            'status' => true,
            'count' => $bookings->count(),
            'data' => $bookings
        ]);
    }

    
    // إنشاء حجز رحلة جديدة
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'flight_id' => 'required|exists:flights,id',
            'flight_type' => 'required|in:one_way,round_trip',
            'departure_city' => 'required|string|max:150',
            'arrival_city' => 'required|string|max:150',
            'departure_date' => 'required|date',
            'return_date' => 'nullable|date|after_or_equal:departure_date',
            'passengers' => 'required|integer|min:1',
            'seat_class' => 'required|string|max:50',
            'total_price' => 'required|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => false,
                'errors' => $validator->errors(),
            ], 422);
        }

        $flight = Flight::findOrFail($request->flight_id);

        if ($flight->available_seats < $request->passengers) {
            return response()->json([
                'status' => false,
                'message' => 'Not enough available seats for this flight.',
            ], 400);
        }

        // إنشاء الحجز
        $booking = FlightBooking::create([
            'user_id' => $request->user()->id,
            'flight_id' => $flight->id,
            'flight_type' => $request->flight_type,
            'departure_city' => $request->departure_city,
            'arrival_city' => $request->arrival_city,
            'departure_date' => $request->departure_date,
            'return_date' => $request->return_date,
            'passengers' => $request->passengers,
            'seat_class' => $request->seat_class,
            'total_price' => $request->total_price,
            'status' => 'pending',
            'payment_status' => 'unpaid',
        ]);

        // خصم المقاعد المتاحة
        $flight->decrement('available_seats', $request->passengers);

        return response()->json([
            'status' => true,
            'message' => 'Flight booking created successfully.',
            'data' => $booking
        ], 201);
    }

    
    // عرض تفاصيل حجز محدد
    public function show($id)
    {
        $booking = FlightBooking::with('flight', 'user')->find($id);

        if (!$booking) {
            return response()->json([
                'status' => false,
                'message' => 'Booking not found.'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'data' => $booking
        ]);
    }

    
    //  تحديث حالة أو تفاصيل الحجز
    public function update(Request $request, $id)
    {
        $booking = FlightBooking::find($id);

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

    
    // حذف حجز رحلة
    public function destroy($id)
    {
        $booking = FlightBooking::find($id);

        if (!$booking) {
            return response()->json([
                'status' => false,
                'message' => 'Booking not found.'
            ], 404);
        }

        $booking->delete();

        return response()->json([
            'status' => true,
            'message' => 'Booking deleted successfully.'
        ]);
    }
}
