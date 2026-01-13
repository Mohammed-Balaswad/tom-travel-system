<?php

namespace Database\Seeders;

use App\Models\Hotel;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;


class HotelSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Hotel::factory()->createMany([
            [
                'destination_id' => 7,
                'name' => 'De Paris',
                'description' => 'Located in the heart of Monte Carlo, the Hotel de Paris is one of the world’s most legendary luxury hotels. Built in 1864, it combines timeless elegance with modern comfort. Guests can enjoy gourmet dining at Michelin-starred restaurants, relax in the Thermes Marins Monte-Carlo spa, or experience the vibrant atmosphere of Casino Square right outside the doors.',
                'image' => 'hotels_images/Hotel-de-Paris.jpg',
                'location' => 'https://www.google.com/maps/place/Hotel+de+Paris+Monte-Carlo/@43.7390901,7.4283979,17z/data=!4m9!3m8!1s0x12cdc287d66c8d15:0xdfd36228428503b7!5m2!4m1!1i2!8m2!3d43.7390048!4d7.4274645!16s%2Fm%2F0b6k1y2?entry=ttu&g_ep=EgoyMDI1MTEyMy4xIKXMDSoASAFQAw%3D%3D',
                'amenities' => [
                    'Free WiFi',
                    'Swimming pool',
                    'Fitness Center',
                    'Spa & Wellness',
                    'Restaurant',
                    'Room Service',
                    'Parking',
                    'Beach Access'
                ],
                'average_rating' => 4.7,
            ],
            [
                'destination_id' => 6,
                'name' => 'Mandarin Oriental',
                'description' => 'Located in the heart of Venice, the Hotel Mandarin Oriental is one of the world’s most legendary luxury hotels. Built in 1864, it combines timeless elegance with modern comfort. Guests can enjoy gourmet dining at Michelin-starred restaurants, relax in the Thermes Marins Monte-Carlo spa, or experience the vibrant atmosphere of Casino Square right outside the doors.',
                'image' => 'hotels_images/Mandarin-Oriental.jpg',
                'location' => 'https://www.google.com/maps/place/Hotel+de+Paris+Monte-Carlo/@43.7390901,7.4283979,17z/data=!4m9!3m8!1s0x12cdc287d66c8d15:0xdfd36228428503b7!5m2!4m1!1i2!8m2!3d43.7390048!4d7.4274645!16s%2Fm%2F0b6k1y2?entry=ttu&g_ep=EgoyMDI1MTEyMy4xIKXMDSoASAFQAw%3D%3D',
                'amenities' => [
                    'Free WiFi',
                    'Swimming pool',
                    'Fitness Center',
                    'Restaurant',
                    'Room Service',
                ],
                'average_rating' => 4.6,
            ],
            [
                'destination_id' => 5,
                'name' => 'The Ritz',
                'description' => 'Located in the heart of Dubai, the Ritz is one of the world’s most legendary luxury hotels. Built in 1864, it combines timeless elegance with modern comfort. Guests can enjoy gourmet dining at Michelin-starred restaurants, relax in the Thermes Marins Monte-Carlo spa, or experience the vibrant atmosphere of Casino Square right outside the doors.',
                'image' => 'hotels_images/The-Ritz.png',
                'location' => 'https://www.google.com/maps/place/Hotel+de+Paris+Monte-Carlo/@43.7390901,7.4283979,17z/data=!4m9!3m8!1s0x12cdc287d66c8d15:0xdfd36228428503b7!5m2!4m1!1i2!8m2!3d43.7390048!4d7.4274645!16s%2Fm%2F0b6k1y2?entry=ttu&g_ep=EgoyMDI1MTEyMy4xIKXMDSoASAFQAw%3D%3D',
                'amenities' => [
                    'Free WiFi',
                    'Swimming pool',
                    'Fitness Center',
                    'Restaurant',
                    'Room Service',
                    'Parking',
                ],
                'average_rating' => 4.8,
            ],
            [
                'destination_id' => 4,
                'name' => 'Park Hyatt',
                'description' => 'Located in the heart of Reykjavík, the Park Hyatt hotel is one of the world’s most legendary luxury hotels. Built in 1864, it combines timeless elegance with modern comfort. Guests can enjoy gourmet dining at Michelin-starred restaurants, relax in the Thermes Marins Monte-Carlo spa, or experience the vibrant atmosphere of Casino Square right outside the doors.',
                'image' => 'hotels_images/Park-Hyatt.png',
                'location' => 'https://www.google.com/maps/place/Hotel+de+Paris+Monte-Carlo/@43.7390901,7.4283979,17z/data=!4m9!3m8!1s0x12cdc287d66c8d15:0xdfd36228428503b7!5m2!4m1!1i2!8m2!3d43.7390048!4d7.4274645!16s%2Fm%2F0b6k1y2?entry=ttu&g_ep=EgoyMDI1MTEyMy4xIKXMDSoASAFQAw%3D%3D',
                'amenities' => [
                    'Free WiFi',
                    'Swimming pool',
                    'Spa & Wellness',
                    'Restaurant',
                    'Room Service',
                    'Beach Access'
                ],
                'average_rating' => 4.6,
            ],
        ]);
    }
}
