<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class FlightBooking extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'flight_id',
        'flight_type',
        'departure_city',
        'arrival_city',
        'departure_date',
        'return_date',
        'passengers',
        'seat_class',
        'total_price',
        'status',
        'payment_status',
    ];

    protected $casts = [
        'passenger_names' => 'array',
        'departure_date' => 'date',
        'return_date' => 'date',
    ];

    public function flight()
    {
        return $this->belongsTo(Flight::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
