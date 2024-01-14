<?php

namespace Database\Seeders;

use App\Models\API\Favorite;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FavSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $jsonfile = file_get_contents(base_path('fav.json'));
        $data = json_decode($jsonfile, true);
        foreach($data as $fav){
            Favorite::create([
                'user_id' => $fav['user_id'],
                'medicine_id' => $fav['medicine_id']
            ]);
        }
    }
}
