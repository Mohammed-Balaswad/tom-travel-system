<?php

namespace App\Http\Controllers\Reviews;

use App\Http\Controllers\Controller;
use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReviewController extends Controller
{
    //  عرض جميع المراجعات (اختياري)
    public function index()
    {
        $reviews = Review::with('user')->latest()->get();

        if ($reviews->isEmpty()) {
            return response()->json(['message' => 'No reviews found'], 404);
        }

        return response()->json([
            'status' => true,
            'count' => $reviews->count(),
            'data' => $reviews,
        ]);
    }

    //  عرض مراجعات كيان معيّن (مثلاً فندق أو مطعم...)
    public function byEntity($type, $id)
    {
        $reviews = Review::where('reviewable_type', $type)
                         ->where('reviewable_id', $id)
                         ->with('user')
                         ->latest()
                         ->get();

        if ($reviews->isEmpty()) {
            return response()->json(['message' => 'No reviews found'], 404);
        }

        return response()->json([
            'status' => true,
            'count' => $reviews->count(),
            'data' => $reviews,
        ]);
    }

    //  إنشاء مراجعة جديدة
    public function store(Request $request)
    {
        $validated = $request->validate([
            'reviewable_type' => 'required|string', // hotel, restaurant, attraction ...
            'reviewable_id' => 'required|integer',
            'rating' => 'required|numeric|min:1|max:5',
            'comment' => 'nullable|string',
        ]);

        $validated['user_id'] = Auth::id();

        $review = Review::create($validated);

        return response()->json([
            'message' => 'Review created successfully',
            'data' => $review->load('user')
        ], 201);
    }

    //  تحديث مراجعة
    public function update(Request $request, $id)
    {
        $review = Review::findOrFail($id);

        if ($review->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'rating' => 'nullable|numeric|min:1|max:5',
            'comment' => 'nullable|string',
        ]);

        $review->update($validated);

        return response()->json([
            'message' => 'Review updated successfully',
            'data' => $review->load('user')
        ]);
    }

    //  حذف مراجعة
    public function destroy($id)
    {
        $review = Review::findOrFail($id);

        if ($review->user_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $review->delete();

        return response()->json(['message' => 'Review deleted successfully']);
    }
}
