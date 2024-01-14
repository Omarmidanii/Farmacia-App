<?php

namespace Database\Seeders;

use App\Models\API\Classification;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ClassificationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {  
        $classifications = [
            'Antibiotics',
            'Analgesics',
            'Antiviral',
            'Antifungal',
            'Gastroenterological',
            'Cardiovascular',
            'Pulmonary',
            'Allergy',
            'Neurological',
            'Painkillers',
            'Antiprotozoal',
            'Hormonal',
            'Ob-Gyn drugs',
            'Antineoplastic',
            'Minerals',
            'Herbal',
            'Musculoskeletal',
            'Ophthalmic',
            'ENT drugs',
            'Dermatological'
        ];
        
        $classifications_arabic = [
            'مضادات حيوية',
             "المسكنات",
             'مضاد فيروسات',
             "مضاد للفطريات",
             "الجهاز الهضمي",
             "القلب والأوعية الدموية",
             "الرئوي",
             'حساسية',
             "العصبية",
             "مسكنات الألم",
             "مضاد للأوالي",
             "الهرمونية",
             " أمراض النساء والتوليد",
             "مضادات الأورام",
             "المعادن",
             "العشبية",
             "العضلات والعظام",
             "طب العيون",
             " الأنف والأذن والحنجرة",
             "جلدية"
        ];
        for($i = 0;$i <20;$i++) {
            Classification::create([
                'name' => $classifications[$i],
                'arabic_name' => $classifications_arabic[$i]
            ]);
        }
    }
}
