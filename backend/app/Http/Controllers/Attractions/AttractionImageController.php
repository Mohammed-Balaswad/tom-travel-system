<?php

namespace App\Http\Controllers\Attractions;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\AttractionImage;
class AttractionImageController extends Controller
{
    //  عرض كل الصور
    public function index()
    {
        $images = AttractionImage::with('attraction')->get();
        return response()->json([
            'status' => true,
            'count' => $images->count(),
            'data' => $images,
        ]);
    }

    //  عرض الصور الخاصة بمعلم سياحي محدد
    public function byAttraction($attraction_id)
    {
        $images = AttractionImage::where('attraction_id', $attraction_id)->get();

        if ($images->isEmpty()) {
            return response()->json([
                'status' => false,
                'message' => 'No images found for this attraction',
            ], 404);
        }

        return response()->json([
            'status' => true,
            'count' => $images->count(),
            'data' => $images,
        ]);
    }

    //  عرض صورة واحدة
    public function show($id)
    {
        $image = AttractionImage::find($id);

        if (!$image) {
            return response()->json(['message' => 'Image not found'], 404);
        }

        return response()->json($image);
    }

    //  إضافة صورة جديدة
    public function store(Request $request)
    {
        $validated = $request->validate([
            'attraction_id' => 'required|exists:attractions,id',
            'image_url' => 'required|string|max:500',
            'caption' => 'nullable|string|max:200',
        ]);

        $image = AttractionImage::create($validated);

        return response()->json([
            'status' => true,
            'message' => 'Image added successfully',
            'data' => $image,
        ], 201);
    }

    //  تحديث صورة
    public function update(Request $request, $id)
    {
        $image = AttractionImage::findOrFail($id);

        $validated = $request->validate([
            'image_url' => 'sometimes|string|max:500',
            'caption' => 'nullable|string|max:200',
        ]);

        $image->update($validated);

        return response()->json([
            'status' => true,
            'message' => 'Image updated successfully',
            'data' => $image,
        ]);
    }

    //  حذف صورة
    public function destroy($id)
    {
        $image = AttractionImage::findOrFail($id);
        $image->delete();

        return response()->json([
            'status' => true,
            'message' => 'Image deleted successfully',
        ]);
    }
}
