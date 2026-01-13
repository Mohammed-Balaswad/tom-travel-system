<?php

namespace App\Http\Controllers\Favorites;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Favorite;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class FavoriteController extends Controller
{
    //  عرض المفضلات
    public function index()
    {
        $favorites = Favorite::with('favorable')
            ->where('user_id', Auth::id())
            ->get();

            foreach ($favorites as $fav) {
                if ($fav->favorable && isset($fav->favorable->image)) {
                    $image = $fav->favorable->image;
        
                    if ($image && !Str::startsWith($image, ['http://', 'https://'])) {
                        $fav->favorable->image = asset('storage/' . $image);
                    }
                }
            }
        
    
        if ($favorites->isEmpty()) {
            return response()->json(['message' => 'No favorites found'], 404);
        }
    
        return response()->json([
            'status' => true,
            'count' => $favorites->count(),
            'data' => $favorites,
        ]);
    }

    //  إضافة عنصر للمفضلة
    public function store(Request $request)
    {
        $validated = $request->validate([
            'favorable_type' => 'required|string',
            'favorable_id' => 'required|integer',
        ]);

        $favorite = Favorite::create([
            'user_id' => Auth::id(),
            ...$validated,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Added to favorites',
            'data' => $favorite,
        ], 201);
    }

    //  حذف عنصر من المفضلة
    public function destroy($id)
    {
        $favorite = Favorite::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $favorite->delete();

        return response()->json([
            'status' => true,
            'message' => 'Removed from favorites',
        ]);
    }
}
