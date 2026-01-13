<?php

namespace App\Http\Controllers\Rooms;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Room;

class RoomController extends Controller
{
    public function index()
    {
        $rooms = Room::with('hotel:id,name')
            ->select('id', 'hotel_id', 'type', 'capacity', 'size', 'price_per_night', 'features', 'description', 'is_available')
            ->paginate(10);

        return response()->json([
            'status' => true,
            'count' => $rooms->count(),
            'data' => $rooms,
        ], 200);
    }

    
    // عرض غرفة معينة بالتفصيل.   
    public function show($id)
    {
        $room = Room::with('hotel:id,name,location')->find($id);

        if (!$room) {
            return response()->json([
                'status' => false,
                'message' => 'Room not found',
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Room details',
            'data' => $room,
        ], 200);
    }

    
    // عرض جميع الغرف التابعة لفندق معين.
    public function byHotel($hotel_id)
    {
        $rooms = Room::where('hotel_id', $hotel_id)
            ->where('is_available', true)
            ->select('id', 'type', 'capacity', 'price_per_night', 'is_available')
            ->get();

        if ($rooms->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'No available rooms found for this hotel',
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Rooms for hotel',
            'data' => $rooms,
        ], 200);
    }
}
