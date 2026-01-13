<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Hotel;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Hotel>
 */
class HotelFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
           'name' => $this->faker->name(),
            'destination_id' => $this->faker->randomElement(Hotel::pluck('id')->toArray()),
            'description' => $this->faker->paragraph(),
            //'image' => $this->faker->imageUrl(),
            'average_rating' => $this->faker->randomFloat(2, 3.0, 5.0),
           // 'location' => $this->faker->randomElement(['City', 'Beach', 'Mountain']),
        ];
    }
}
