<?php

namespace Database\Seeders;

use App\Models\Room;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Room::factory()->create([
            'hotel_id' => 1,
            'type' => 'Suite',
            'capacity' => 5,
            'size' => 'LARGE',
            'price_per_night' => 150,
            'features' => null,
            'description' => null,
            'is_available' => true,
        ]);
    }
}
