<?php

namespace App\Http\Controllers\UserTrips;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Models\HotelBooking;
use App\Models\FlightBooking;

class MyTripController extends Controller
{
    //  عرض جميع الرحلات والحجوزات الخاصة بالمستخدم
    public function index()
{
    $userId = Auth::id();

    $hotelBookings = HotelBooking::with(['hotel.destination', 'room'])
        ->where('user_id', $userId)
        ->get();

    $flightBookings = FlightBooking::with('flight')
        ->where('user_id', $userId)
        ->get();

    // معالجة الصور للفنادق
    foreach ($hotelBookings as $booking) {
        if ($booking->hotel && $booking->hotel->image) {
            $booking->hotel->image = asset('storage/' . $booking->hotel->image);
        }
        if ($booking->room && $booking->room->image) {
            $booking->room->image = asset('storage/' . $booking->room->image);
        }
    }

    // معالجة الصور للرحلات
    foreach ($flightBookings as $booking) {
        if ($booking->flight && $booking->flight->image) {
            $booking->flight->image = asset('storage/' . $booking->flight->image);
        }
    }

    return response()->json([
        'status' => true,
        'message' => 'User trips fetched successfully',
        'data' => [
            'hotel_bookings' => $hotelBookings,
            'flight_bookings' => $flightBookings,
        ],
    ]);
}
}
