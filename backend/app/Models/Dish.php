<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Dish extends Model
{
    use HasFactory;

    protected $fillable = [
        'restaurant_id',
        'category',
        'name',
        'price',
        'average_rating',
        'description',
        'image',
    ];

    public function restaurant()
    {
        return $this->belongsTo(Restaurant::class);
    }
}
