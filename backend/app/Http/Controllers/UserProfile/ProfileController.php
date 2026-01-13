<?php

namespace App\Http\Controllers\UserProfile;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{
    //  عرض بيانات المستخدم الحالية
    public function show()
    {
        $user = Auth::user();
        

        return response()->json([
            'status' => true,
            'message' => 'User profile data',
            'data' => $user,
        ]);
    }

    //  تحديث بيانات المستخدم
public function update(Request $request)
{
    
    $user = User::find(Auth::id());

    $validated = $request->validate([
        'name' => 'sometimes|string|max:150',
        'email' => 'sometimes|email|max:150|unique:users,email,' . $user->id,
        'phone' => 'nullable|string|max:30',
        'profile_image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
    ]);

    if ($request->hasFile('profile_image')) {
        $path = $request->file('profile_image')->store('profile_images', 'public');
        $validated['profile_image'] = $path;
    }   

    $user->update($validated);

    return response()->json([
        'status' => true,
        'message' => 'Profile updated successfully',
        'user' => [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'phone' => $user->phone,
            'profile_image' => $user->profile_image ? asset('storage/' . $user->profile_image) : null,
            'role' => $user->role,
        ],
    ], 200);
}

}
