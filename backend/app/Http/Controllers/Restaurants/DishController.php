<?php

namespace App\Http\Controllers\Restaurants;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Dish;

class DishController extends Controller
{
    //  عرض جميع الأطباق
    public function index()
    {
        $dishes = Dish::with('restaurant')->get();

        return response()->json([
            'status' => true,
            'count' => $dishes->count(),
            'data' => $dishes,
        ]);
    }

    //  عرض طبق واحد
    public function show($id)
    {
        $dish = Dish::with('restaurant')->find($id);

        if (!$dish) {
            return response()->json(['message' => 'Dish not found'], 404);
        }

        return response()->json($dish);
    }

    //  عرض جميع الأطباق التابعة لمطعم محدد
    public function getByRestaurant($restaurantId)
    {
        $dishes = Dish::where('restaurant_id', $restaurantId)
            ->with('restaurant')
            ->get();

        if ($dishes->isEmpty()) {
            return response()->json(['message' => 'No dishes found for this restaurant'], 404);
        }

        return response()->json($dishes);
    }

    //  إنشاء طبق جديد
    public function store(Request $request)
    {
        $validated = $request->validate([
            'restaurant_id' => 'required|exists:restaurants,id',
            'category' => 'nullable|string|max:80',
            'name' => 'required|string|max:200',
            'price' => 'required|numeric|min:0',
            'average_rating' => 'nullable|numeric|min:0|max:5',
            'description' => 'nullable|string',
            'image' => 'nullable|string|max:500',
        ]);

        $dish = Dish::create($validated);

        return response()->json($dish, 201);
    }

    //  تحديث طبق
    public function update(Request $request, $id)
    {
        $dish = Dish::findOrFail($id);

        $validated = $request->validate([
            'category' => 'nullable|string|max:80',
            'name' => 'sometimes|string|max:200',
            'price' => 'sometimes|numeric|min:0',
            'average_rating' => 'nullable|numeric|min:0|max:5',
            'description' => 'nullable|string',
            'image' => 'nullable|string|max:500',
        ]);

        $dish->update($validated);
        return response()->json($dish);
    }

    //  حذف طبق
    public function destroy($id)
    {
        $dish = Dish::findOrFail($id);
        $dish->delete();

        return response()->json(['message' => 'Dish deleted successfully']);
    }
}
