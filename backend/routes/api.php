<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Destinations\DestinationController;
use App\Http\Controllers\Hotels\HotelController;
use App\Http\Controllers\Rooms\RoomController;
use App\Http\Controllers\Booking\HotelBookingController;
use App\Http\Controllers\Flight\FlightController;
use App\Http\Controllers\Booking\FlightBookingController;
use App\Http\Controllers\Attractions\AttractionController;
use App\Http\Controllers\Attractions\AttractionImageController;
use App\Http\Controllers\Restaurants\RestaurantController;
use App\Http\Controllers\Restaurants\DishController;
use App\Http\Controllers\Reviews\ReviewController;
use App\Http\Controllers\Notifications\NotificationController;
use App\Http\Controllers\Favorites\FavoriteController;
use App\Http\Controllers\UserProfile\ProfileController;
use App\Http\Controllers\UserTrips\MyTripController;
use App\Http\Controllers\Search\SearchController;

// Auth
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Logout
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
});


// Destinations
Route::prefix('destinations')->group(function () {
    Route::get('/', [DestinationController::class, 'index']); // عرض كل الوجهات
    Route::get('/{id}', [DestinationController::class, 'show']); // عرض وجهة محددة
});


// Hotels
Route::prefix('hotels')->group(function () {
    Route::get('/', [HotelController::class, 'index']); // عرض كل الفنادق
    Route::get('/{id}', [HotelController::class, 'show']); // عرض فندق معين
    Route::get('/destination/{destination_id}', [HotelController::class, 'byDestination']); // عرض الفنادق التابعة لوجهة معينة
});


// Rooms
Route::prefix('rooms')->group(function () {
    Route::get('/', [RoomController::class, 'index']); // كل الغرف
    Route::get('/{id}', [RoomController::class, 'show']); // تفاصيل غرفة واحدة
    Route::get('/hotel/{hotel_id}', [RoomController::class, 'byHotel']); // الغرف التابعة لفندق معين
});


// Hotel Bookings
Route::middleware('auth:sanctum')->prefix('hotel-bookings')->group(function () {
    Route::get('/', [HotelBookingController::class, 'index']);
    Route::post('/', [HotelBookingController::class, 'store']);
    Route::put('/{id}', [HotelBookingController::class, 'update']);   // تحديث حجز
    Route::get('/{id}', [HotelBookingController::class, 'show']);
    Route::patch('/{id}/cancel', [HotelBookingController::class, 'cancel']);
});


// Flights
Route::prefix('flights')->group(function () {
    Route::get('/', [FlightController::class, 'index']);         // عرض كل الرحلات
    Route::get('/{id}', [FlightController::class, 'show']);      // عرض رحلة محددة
    Route::post('/', [FlightController::class, 'store']);        // إنشاء رحلة جديدة
    Route::put('/{id}', [FlightController::class, 'update']);    // تحديث رحلة
    Route::delete('/{id}', [FlightController::class, 'destroy']); // حذف رحلة
});


//  Flight Bookings
Route::middleware('auth:sanctum')->prefix('flight-bookings')->group(function () {
    Route::get('/', [FlightBookingController::class, 'index']);        // عرض حجوزات المستخدم
    Route::get('/{id}', [FlightBookingController::class, 'show']);     // عرض حجز محدد
    Route::post('/', [FlightBookingController::class, 'store']);       // إنشاء حجز جديد
    Route::put('/{id}', [FlightBookingController::class, 'update']);   // تحديث حجز
    Route::delete('/{id}', [FlightBookingController::class, 'destroy']); // إلغاء أو حذف حجز
});


//  Attractions
Route::prefix('attractions')->group(function () {
    Route::get('/', [AttractionController::class, 'index']);
    Route::get('/{id}', [AttractionController::class, 'show']);
    Route::post('/', [AttractionController::class, 'store']);
    Route::put('/{id}', [AttractionController::class, 'update']);
    Route::delete('/{id}', [AttractionController::class, 'destroy']);
});


//  Attraction Images
Route::prefix('attraction-images')->group(function () {
    Route::get('/', [AttractionImageController::class, 'index']);
    Route::get('/{id}', [AttractionImageController::class, 'show']);
    Route::get('/by-attraction/{attraction_id}', [AttractionImageController::class, 'byAttraction']);
    Route::post('/', [AttractionImageController::class, 'store']);
    Route::put('/{id}', [AttractionImageController::class, 'update']);
    Route::delete('/{id}', [AttractionImageController::class, 'destroy']);
});


//  Restaurants
Route::prefix('restaurants')->group(function () {
    Route::get('/', [RestaurantController::class, 'index']);
    Route::get('/{id}', [RestaurantController::class, 'show']);
    Route::post('/', [RestaurantController::class, 'store']);
    Route::put('/{id}', [RestaurantController::class, 'update']);
    Route::delete('/{id}', [RestaurantController::class, 'destroy']);
});


//  Dishes
Route::prefix('dishes')->group(function () {
    Route::get('/', [DishController::class, 'index']);
    Route::get('/{id}', [DishController::class, 'show']);
    Route::get('/by-restaurant/{restaurantId}', [DishController::class, 'getByRestaurant']);
    Route::post('/', [DishController::class, 'store']);
    Route::put('/{id}', [DishController::class, 'update']);
    Route::delete('/{id}', [DishController::class, 'destroy']);
});


//  Reviews
Route::prefix('reviews')->group(function () {
    Route::get('/', [ReviewController::class, 'index']);
    Route::get('/{type}/{id}', [ReviewController::class, 'byEntity']); // مثال: /reviews/hotel/3
    Route::post('/', [ReviewController::class, 'store'])->middleware('auth:sanctum');
    Route::put('/{id}', [ReviewController::class, 'update'])->middleware('auth:sanctum');
    Route::delete('/{id}', [ReviewController::class, 'destroy'])->middleware('auth:sanctum');
});


//  Notifications
Route::middleware('auth:sanctum')->prefix('notifications')->group(function () {
    Route::get('/', [NotificationController::class, 'index']);
    Route::post('/', [NotificationController::class, 'store']);
    Route::put('/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::delete('/{id}', [NotificationController::class, 'destroy']);
});


//  Favorites
Route::middleware('auth:sanctum')->prefix('favorites')->group(function () {
    Route::get('/', [FavoriteController::class, 'index']);
    Route::post('/', [FavoriteController::class, 'store']);
    Route::delete('/{id}', [FavoriteController::class, 'destroy']);
});


//  User Profile
Route::middleware('auth:sanctum')->prefix('profile')->group(function () {
    Route::get('/', [ProfileController::class, 'show']);
    Route::put('/', [ProfileController::class, 'update']);
});


//  User Trips
Route::middleware('auth:sanctum')->prefix('my-trips')->group(function () {
    Route::get('/', [MyTripController::class, 'index']);
});


//  Search
Route::get('/search', [SearchController::class, 'search']);


