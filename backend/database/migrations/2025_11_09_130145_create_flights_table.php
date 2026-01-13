<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('flights', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('airline', 150);
            $table->string('flight_number', 50)->nullable();
            $table->string('aircraft_model', 150)->nullable();
            $table->string('image', 500)->nullable();
            $table->string('departure_city', 150);
            $table->string('arrival_city', 150);
            $table->string('departure_airport', 200)->nullable();
            $table->string('arrival_airport', 200)->nullable();
            $table->dateTime('departure_time');
            $table->dateTime('arrival_time');
            $table->string('duration', 50)->nullable();
            $table->enum('cabin_class', ['Economy','Business','First'])->default('Economy');
            $table->json('baggage_policy')->nullable();
            $table->json('amenities')->nullable();
            $table->decimal('price', 10, 2);
            $table->integer('available_seats')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('flights');
    }
};
