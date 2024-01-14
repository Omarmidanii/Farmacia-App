<?php

namespace Database\Seeders;

use App\Models\API\Medicine;
use Hamcrest\Core\HasToString;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MedsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $jsonfile = file_get_contents(base_path('meds.json'));
        $data = json_decode($jsonfile, true);
        foreach($data as $med){
            Medicine::create([
                'scientific_name'=> $med['scientific_name'] ,
                'commercial_name' => $med['commercial_name'],
                'manufacture_company' => $med['manufacture_company'],
                'Available_quantity'=>$med['Available_quantity'],
                'Expiration_date'=>$med['Expiration_date'],
                'price'=>$med['price'],
                'classification_id'=>$med['classification_id'],
            ]);
        }
    }
}
