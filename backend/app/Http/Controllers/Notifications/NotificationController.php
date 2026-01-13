<?php

namespace App\Http\Controllers\Notifications;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Notification;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
    //  عرض جميع الإشعارات الخاصة بالمستخدم
    public function index()
    {
        $notifications = Notification::where('user_id', Auth::id())
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'status' => true,
            'count' => $notifications->count(),
            'data' => $notifications,
        ]);
    }

    //  إنشاء إشعار 
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'type' => 'required|string|max:100',
            'payload' => 'nullable|array',
        ]);

        $notification = Notification::create([
            ...$validated,
            'is_read' => false,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Notification sent successfully',
            'data' => $notification,
        ], 201);
    }

    //  تحديث حالة الإشعار كمقروء
    public function markAsRead($id)
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $notification->update(['is_read' => true]);

        return response()->json([
            'status' => true,
            'message' => 'Notification marked as read',
        ]);
    }

    //  حذف إشعار
    public function destroy($id)
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $notification->delete();

        return response()->json([
            'status' => true,
            'message' => 'Notification deleted successfully',
        ]);
    }
}
