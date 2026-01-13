<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Hotel extends Model
{
    use HasFactory;

    protected $fillable = [
        'destination_id',
        'name',
        'description',
        'image',
        'location',
        'amenities',
        'average_rating',
    ];

    protected $casts = [
        'amenities' => 'array',
    ];

    public function destination()
    {
        return $this->belongsTo(Destination::class);
    }

    public function rooms()
    {
        return $this->hasMany(Room::class);
    }

    public function bookings()
    {
        return $this->hasMany(HotelBooking::class);
    }
    
    public function reviews()
    {
    return $this->morphMany(Review::class, 'reviewable');
    }
}
