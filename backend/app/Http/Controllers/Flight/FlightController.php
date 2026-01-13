<?php

namespace App\Http\Controllers\Flight;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Flight;
use Illuminate\Support\Facades\Validator;

class FlightController extends Controller
{
    //  عرض كل الرحلات  
    public function index()
    {
        $flights = Flight::all();

        return response()->json([
            'status' => true,
            'count' => $flights->count(),
            'data' => $flights,
        ]);
    }

    //  عرض رحلة محددة
    public function show($id)
    {
        $flight = Flight::find($id);
        if (!$flight) {
            return response()->json(['message' => 'Flight not found'], 404);
        }

        return response()->json($flight);
    }

    //  إنشاء رحلة جديدة (للمسؤول)
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'airline' => 'required|string|max:150',
            'flight_number' => 'nullable|string|max:50',
            'aircraft_model' => 'nullable|string|max:150',
            'image' => 'nullable|string|max:500',
            'departure_city' => 'required|string|max:150',
            'arrival_city' => 'required|string|max:150',
            'departure_airport' => 'nullable|string|max:200',
            'arrival_airport' => 'nullable|string|max:200',
            'departure_time' => 'required|date',
            'arrival_time' => 'required|date|after:departure_time',
            'duration' => 'nullable|string|max:50',
            'cabin_class' => 'in:Economy,Business,First',
            //  baggage_policy و amenities JSON
            'baggage_policy' => 'nullable|array',
            'amenities' => 'nullable|array',
            'price' => 'required|numeric|min:0',
            'available_seats' => 'required|integer|min:0',
        ]);
    
        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // إنشاء الرحلة
        $flight = Flight::create([
            'airline' => $request->airline,
            'flight_number' => $request->flight_number,
            'aircraft_model' => $request->aircraft_model,
            'image' => $request->image,
            'departure_city' => $request->departure_city,
            'arrival_city' => $request->arrival_city,
            'departure_airport' => $request->departure_airport,
            'arrival_airport' => $request->arrival_airport,
            'departure_time' => $request->departure_time,
            'arrival_time' => $request->arrival_time,
            'duration' => $request->duration,
            'cabin_class' => $request->cabin_class ?? 'Economy',
            'baggage_policy' => $request->baggage_policy,
            'amenities' => $request->amenities,
            'price' => $request->price,
            'available_seats' => $request->available_seats,
        ]);

        return response()->json([
            'message' => 'Flight created successfully',
            'data' => $flight
        ], 201);
    }

    //  تحديث رحلة
    public function update(Request $request, $id)
    {
        $flight = Flight::find($id);
        if (!$flight) {
            return response()->json(['message' => 'Flight not found'], 404);
        }

        $validator = Validator::make($request->all(), [
            'airline' => 'sometimes|string|max:150',
            'flight_number' => 'nullable|string|max:50',
            'aircraft_model' => 'nullable|string|max:150',
            'image' => 'nullable|string|max:500',
            'departure_city' => 'sometimes|string|max:150',
            'arrival_city' => 'sometimes|string|max:150',
            'departure_airport' => 'nullable|string|max:200',
            'arrival_airport' => 'nullable|string|max:200',
            'departure_time' => 'sometimes|date',
            'arrival_time' => 'sometimes|date|after:departure_time',
            'duration' => 'nullable|string|max:50',
            'cabin_class' => 'in:Economy,Business,First',
            'baggage_policy' => 'nullable|array',
            'amenities' => 'nullable|array',
            'price' => 'sometimes|numeric|min:0',
            'available_seats' => 'sometimes|integer|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $flight->update($validator->validated());

        return response()->json([
            'message' => 'Flight updated successfully ✈️',
            'data' => $flight
        ]);
    }

    //  حذف رحلة
    public function destroy($id)
    {
        $flight = Flight::find($id);
        if (!$flight) {
            return response()->json(['message' => 'Flight not found'], 404);
        }

        $flight->delete();

        return response()->json(['message' => 'Flight deleted successfully']);
    }
}
