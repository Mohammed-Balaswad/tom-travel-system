<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Destination;


/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Destination>
 */
class DestinationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Destination::class;

    public function definition(): array
    {
        return [
            'name' => $this->faker->city(),
            'country' => $this->faker->country(),
            'description' => $this->faker->paragraph(),
            //'image' => $this->faker->imageUrl(),
            'average_rating' => $this->faker->randomFloat(2, 3.0, 5.0),
            'category' => $this->faker->randomElement(['City', 'Beach', 'Mountain']),
        ];
    }

}
