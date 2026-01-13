<?php

namespace App\Http\Controllers\Search;

use App\Http\Controllers\Controller;
use App\Models\Destination;
use App\Models\Hotel;
use App\Models\Attraction;
use Illuminate\Http\Request;

class SearchController extends Controller
{
    public function search(Request $request)
    {
        $q = trim($request->input('q', ''));
        if (strlen($q) < 2) {
            return response()->json(['results' => []]);
        }

        // بحث في الوجهات (destinations)
        $destinations = Destination::select('id', 'name', 'country', 'image')
            ->where('name', 'like', "%{$q}%")
            ->get()
            ->map(function ($d) {
                return [
                    'id' => $d->id,
                    'type' => 'destination',
                    'title' => $d->name,
                    'subtitle' => $d->country,
                    'image' => $d->image ? asset('storage/' . $d->image) : null,
                ];
            });

        // بحث في الفنادق (hotels) — لنأخذ اسم الفندق + اسم البلد من العلاقة destination
        $hotels = Hotel::with('destination:id,name,country')
            ->select('id', 'name', 'image', 'destination_id')
            ->where('name', 'like', "%{$q}%")
            ->get()
            ->map(function ($h) {
                return [
                    'id' => $h->id,
                    'type' => 'hotel',
                    'title' => $h->name,
                    'subtitle' => optional($h->destination)->country ?? null,
                    'image' => $h->image ? asset('storage/' . $h->image) : null,
                ];
            });

        // بحث في الأماكن السياحية (attractions)
        $attractions = Attraction::select('id', 'name', 'image', 'location')
            ->where('name', 'like', "%{$q}%")
            ->get()
            ->map(function ($a) {
                return [
                    'id' => $a->id,
                    'type' => 'attraction',
                    'title' => $a->name,
                    'subtitle' => optional($a->destination)->country ?? null,
                    'image' => $a->image ? asset('storage/' . $a->image) : null,
                ];
            });

        // دمج النتائج: كونهم Collections من arrays => concat آمن
        $results = $destinations->concat($hotels)->concat($attractions);

        // اختياري: ترتيب/تصفية أو حَدّ للنتائج النهائية
        $results = $results->values()->slice(0, 20);

        return response()->json([
            'results' => $results,
        ]);
    }
}
