<?php

namespace App\Http\Controllers\Attractions;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Attraction;

class AttractionController extends Controller
{
    // عرض كل المعالم (مع الصور)
    public function index()
    {
        $attractions = Attraction::with('images', 'destination')
            ->select('id', 'destination_id', 'name', 'location', 'description', 'open_hours', 'average_rating', 'image')
            ->orderBy('average_rating', 'desc')
            ->get();

        return response()->json([
            'status' => true,
            'count' => $attractions->count(),
            'data' => $attractions,
        ]);
    }

    // عرض معلم محدد بالتفصيل
    public function show($id)
{
    $attraction = Attraction::with(['images', 'destination', 'reviews.user'])->find($id);

    if (!$attraction) {
        return response()->json([
            'status' => false,
            'message' => 'Attraction not found',
        ], 404);
    }

    return response()->json([
        'status' => true,
        'message' => 'Attraction details',
        'data' => $attraction,
    ]);
}


     //  إنشاء معلم جديد 
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
 
         $attraction = Attraction::create($validated);
 
         return response()->json($attraction, 201);
     }
 
     //  تحديث بيانات معلم
     public function update(Request $request, $id)
     {
         $attraction = Attraction::findOrFail($id);
 
         $validated = $request->validate([
             'name' => 'sometimes|string|max:200',
             'location' => 'nullable|string|max:500',
             'description' => 'nullable|string',
             'open_hours' => 'nullable|string|max:100',
             'image' => 'nullable|string|max:500',
             'average_rating' => 'nullable|numeric|min:0|max:5',
         ]);
 
         $attraction->update($validated);
 
         return response()->json($attraction);
     }
 
     //  حذف معلم 
     public function destroy($id)
     {
         $attraction = Attraction::findOrFail($id);
         $attraction->delete();
 
         return response()->json(['message' => 'Attraction deleted successfully']);
     }
}
