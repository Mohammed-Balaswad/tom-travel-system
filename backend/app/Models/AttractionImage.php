<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AttractionImage extends Model
{
    use HasFactory;

    protected $fillable = [
        'attraction_id',
        'image_url',
        'caption',
    ];

    public function attraction()
    {
        return $this->belongsTo(Attraction::class);
    }
}
