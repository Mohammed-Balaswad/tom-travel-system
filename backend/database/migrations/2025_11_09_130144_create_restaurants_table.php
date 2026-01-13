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
        Schema::create('restaurants', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->foreignId('destination_id')->constrained('destinations')->onDelete('cascade');
            $table->string('name', 200);
            $table->string('location', 500)->nullable();
            $table->text('description')->nullable();
            $table->string('open_hours', 100)->nullable();
            $table->string('image', 500)->nullable();
            $table->decimal('average_rating', 3, 2)->default(0.00);
            $table->timestamps();

            $table->index('destination_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('restaurants');
    }
};
