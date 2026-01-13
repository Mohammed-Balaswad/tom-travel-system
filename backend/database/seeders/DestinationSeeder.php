<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Destination;


class DestinationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Destination::factory()->createMany([
            [
                'name' => 'Oia, Santorini',
                'country' => 'Greece',
                'description' => 'Oia, Santorini is a heart-shaped tropical paradise located in greece, surrounded by crystal-clear waters and coral reefs. The island spans approximately 29 acres and is known for its luxury surf resort, pristine white sand beaches, and world-famous surfing spots like Cloudbreak, Restaurants, and Tavarua Rights.',
                'image' => 'destinations_images/Oia_Santorini.png',
                'average_rating' => 4.8,
                'category' => 'City',
            ],
            [
                'name' => 'Reykjavík',
                'country' => 'Iceland',
                'description' => 'Reykjavík, the capital of Iceland, is a vibrant coastal city known for its colorful houses, modern architecture, and proximity to stunning natural wonders such as geysers, glaciers, and the Northern Lights. It combines a lively cultural scene with cozy cafés, geothermal pools, and a strong connection to Viking heritage, making it both charming and adventurous.',
                'image' => 'destinations_images/Reykjavík.png',
                'average_rating' => 4.9,
                'category' => 'City',
            ],
            [
                'name' => 'Dubai',
                'country' => 'UAE',
                'description' => 'Dubai, located in the United Arab Emirates, is a dazzling metropolis famous for its futuristic skyline, luxury shopping, and world‑class attractions like the Burj Khalifa and Palm Jumeirah. It blends traditional Arabian culture with modern innovation, offering desert safaris, pristine beaches, and a cosmopolitan lifestyle that attracts millions of visitors each year.',
                'image' => 'destinations_images/Dubai.png',
                'average_rating' => 4.7,
                'category' => 'City',
            ],
            [
                'name' => 'Venice',
                'country' => 'Italy',
                'description' => 'Venice, in northeastern Italy, is a romantic city built on canals, where gondolas glide past Renaissance palaces and historic bridges. Known for landmarks such as St. Mark’s Basilica and the Grand Canal, it offers a unique atmosphere of art, history, and charm, with narrow alleyways, lively piazzas, and timeless beauty that has inspired travelers for centuries.',
                'image' => 'destinations_images/Venice.png',
                'average_rating' => 4.6,
                'category' => 'City',
            ],
            [
                'name' => 'Paris',
                'country' => 'France',
                'description' => 'Paris, the capital of France, is celebrated as the “City of Light” and a global center of art, fashion, and gastronomy. Iconic landmarks like the Eiffel Tower, Louvre Museum, and Notre‑Dame Cathedral highlight its rich history, while elegant boulevards, charming cafés, and romantic ambiance make it one of the most beloved destinations in the world.',
                'image' => 'destinations_images/Paris.png',
                'average_rating' => 4.3,
                'category' => 'City',
            ],
        ]);
    }
}
