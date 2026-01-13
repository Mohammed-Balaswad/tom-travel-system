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
        Schema::create('flight_bookings', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->foreignId('flight_id')->constrained('flights')->onDelete('cascade');
            $table->enum('flight_type', ['one_way','round_trip'])->default('one_way');
            $table->string('departure_city', 150);
            $table->string('arrival_city', 150);
            $table->date('departure_date');
            $table->date('return_date')->nullable();
            $table->integer('passengers')->default(1);
            $table->string('seat_class', 50)->nullable();
            $table->decimal('total_price', 10, 2);
            $table->enum('status', ['pending','confirmed','rejected','cancelled'])->default('pending');
            $table->enum('payment_status', ['unpaid','paid'])->default('unpaid');
            $table->timestamps();

            $table->index(['user_id', 'flight_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('flight_bookings');
    }
};
