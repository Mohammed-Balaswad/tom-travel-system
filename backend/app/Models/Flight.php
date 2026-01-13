<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Flight extends Model
{
    use HasFactory;

    protected $fillable = [
        'airline',
        'flight_number',
        'aircraft_model',
        'image',
        'departure_city',
        'arrival_city',
        'departure_airport',
        'arrival_airport',
        'departure_time',
        'arrival_time',
        'duration',
        'cabin_class',
        'baggage_policy',
        'amenities',
        'price',
        'available_seats',
    ];

    protected $casts = [
        'baggage_policy' => 'array',
        'amenities' => 'array',
        'departure_time' => 'datetime',
        'arrival_time' => 'datetime',
    ];

    public function bookings()
    {
        return $this->hasMany(FlightBooking::class);
    }
}
