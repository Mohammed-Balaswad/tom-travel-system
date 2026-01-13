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
        Schema::create('attraction_images', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->foreignId('attraction_id')->constrained('attractions')->onDelete('cascade');
            $table->string('image_url', 500);
            $table->string('caption', 200)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attraction_images');
    }
};
