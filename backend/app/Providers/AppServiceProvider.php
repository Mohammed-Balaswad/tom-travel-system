<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Database\Eloquent\Relations\Relation;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Relation::enforceMorphMap([
            'user' => 'App\Models\User',
            'hotel' => 'App\Models\Hotel',
            'restaurant' => 'App\Models\Restaurant',
            'attraction' => 'App\Models\Attraction',
            'flight' => 'App\Models\Flight',
            'destination' => 'App\Models\Destination',
        ]);
    }
}
