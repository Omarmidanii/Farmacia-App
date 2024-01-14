<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $jsonfile = file_get_contents(base_path('users.json'));
        $data = json_decode($jsonfile, true);
        foreach($data as $user){
            User::create([
                'username' => $user['username'],
                'Phonenumber' => $user['Phonenumber'],
                'Password' => Hash::make($user['Password']),
            ]);
        }
    }
}
