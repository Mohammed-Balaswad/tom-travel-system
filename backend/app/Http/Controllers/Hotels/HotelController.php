<?php

namespace App\Http\Controllers\Hotels;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Hotel;

class HotelController extends Controller
{
    public function index()
    {
        $hotels = Hotel::with('destination:id,name,country')
            ->select('id', 'name', 'destination_id', 'image','description', 'amenities', 'average_rating', 'location')
            ->orderByDesc('average_rating')
            ->paginate(10);

             foreach ($hotels as $hotel) {
                if ($hotel->image) {
                    $hotel->image = asset('storage/' . $hotel->image);
                }
            }
            
            return response()->json(data: $hotels);
        // return response()->json([
        //     'status' => true,
        //     'count' => $hotels->count(),
        //     'data' => $hotels
        // ], 200);
    }

    
    // عرض فندق معين بالتفصيل.
    public function show($id)
    {
        $hotel = Hotel::with([
            'destination',
            'rooms',
            'reviews.user'  
        ])->find($id);
        
            if ($hotel->image) {
                    $hotel->image = asset('storage/' . $hotel->image);
                }

        if (!$hotel) {
            return response()->json([
                'status' => false,
                'message' => 'Hotel not found'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Hotel details',
            'data' => $hotel
        ], 200);
    }

    
    //   عرض الفنادق التابعة لوجهة معينة.
    public function byDestination($destination_id)
    {
        $hotels = Hotel::where('destination_id', $destination_id)
            ->with('destination:id,name')
            ->select('id', 'name', 'image','description', 'amenities', 'average_rating', 'location')
            ->get();

            foreach ($hotels as $hotel) {
                if ($hotel->image) {
                    $hotel->image = asset('storage/' . $hotel->image);
                }
            }

        if ($hotels->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'No hotels found for this destination'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Hotels for destination',
            'data' => $hotels
        ], 200);
    }
}
