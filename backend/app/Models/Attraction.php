<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class Attraction extends Model
{
    use HasFactory;

    protected $fillable = [
        'destination_id',
        'name',
        'location',
        'description',
        'open_hours',
        'average_rating',
        'gallery',
        'image',
    ];

    protected $casts = [
        'gallery' => 'array',
    ];

    public function destination()
    {
        return $this->belongsTo(Destination::class);
    }

    public function images()
    {
        return $this->hasMany(AttractionImage::class);
    }

    public function reviews()
    {
    return $this->morphMany(Review::class, 'reviewable');
    }
}
