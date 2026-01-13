<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Destination extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'country',
        'description',
        'image',
        'average_rating',
        'category',
    ];

    // علاقات
    public function hotels()
    {
        return $this->hasMany(Hotel::class);
    }

    public function restaurants()
    {
        return $this->hasMany(Restaurant::class);
    }

    public function attractions()
    {
        return $this->hasMany(Attraction::class);
    }

    public function reviews()
    {
    return $this->morphMany(Review::class, 'reviewable');
    }
}
