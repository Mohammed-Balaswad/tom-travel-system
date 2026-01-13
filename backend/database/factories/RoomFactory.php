<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Room>
 */
class RoomFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'hotel_id' => 1,
            'type' => 'Suite',
            'capacity' => 5,
            'size' => 'LARGE',
            'price_per_night' => 150,
            'features' => null,
            'description' => null,
            'is_available' => true,
        ];
    }
}
