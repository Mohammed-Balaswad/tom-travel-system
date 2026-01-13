<?php

namespace App\Http\Controllers\Restaurants;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Restaurant;
use App\Models\Dish;

class RestaurantController extends Controller
{
    //  عرض جميع المطاعم مع الأطباق المرتبطة
    public function index()
    {
        $restaurants = Restaurant::with('dishes')->get();
        
        foreach ($restaurants as $restaurant) {
            if ($restaurant->image) {
                $restaurant->image = asset('storage/' . $restaurant->image);
            }
        }
        return response()->json([
            'status' => true,
            'count' => $restaurants->count(),
            'data' => $restaurants,
        ]);
    }

    //  عرض مطعم محدد مع الأطباق
    public function show($id)
{
    $restaurant = Restaurant::with(['dishes', 'reviews.user'])->find($id);

    if (!$restaurant) {
        return response()->json([
            'status' => false,
            'message' => 'Restaurant not found'
        ], 404);
    }

    return response()->json([
        'status' => true,
        'message' => 'Restaurant details',
        'data' => $restaurant
    ]);
}


    //  إنشاء مطعم جديد 
    public function store(Request $request)
    {
        $validated = $request->validate([
            'destination_id' => 'required|exists:destinations,id',
            'name' => 'required|string|max:200',
            'location' => 'nullable|string|max:500',
            'description' => 'nullable|string',
            'open_hours' => 'nullable|string|max:100',
            'image' => 'nullable|string|max:500',
            'average_rating' => 'nullable|numeric|min:0|max:5',
        ]);

        $restaurant = Restaurant::create($validated);

        return response()->json($restaurant, 201);
    }

    //  تحديث بيانات مطعم
    public function update(Request $request, $id)
    {
        $restaurant = Restaurant::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:200',
            'location' => 'nullable|string|max:500',
            'description' => 'nullable|string',
            'open_hours' => 'nullable|string|max:100',
            'image' => 'nullable|string|max:500',
            'average_rating' => 'nullable|numeric|min:0|max:5',
        ]);

        $restaurant->update($validated);

        return response()->json($restaurant);
    }

    //  حذف مطعم 
    public function destroy($id)
    {
        $restaurant = Restaurant::findOrFail($id);
        $restaurant->delete();

        return response()->json(['message' => 'Restaurant deleted successfully']);
    }
}
