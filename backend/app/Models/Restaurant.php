<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Restaurant extends Model
{
    use HasFactory;

    protected $fillable = [
        'destination_id',
        'name',
        'location',
        'description',
        'open_hours',
        'image',
        'average_rating',
    ];

    public function destination()
    {
        return $this->belongsTo(Destination::class);
    }

    public function dishes()
    {
        return $this->hasMany(Dish::class);
    }

    public function reviews()
    {
    return $this->morphMany(Review::class, 'reviewable');
    }
}
