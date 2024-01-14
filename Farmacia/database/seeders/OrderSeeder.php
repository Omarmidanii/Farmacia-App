<?php

namespace Database\Seeders;

use App\Models\API\Order;
use App\Models\API\Order_Medicine;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $jsonfile = file_get_contents(base_path('order.json'));
        $data = json_decode($jsonfile, true);
        foreach($data as $order){
            Order::create([
                'user_id' => $order['user_id'],
                'created_at' => $order['created_at']
            ]);
        }
        $jsonfile = file_get_contents(base_path('order_items.json'));
        $data = json_decode($jsonfile, true);
        foreach($data as $order){
            Order_Medicine::create([
                'order_id' => $order['orders_id'],
                'medicine_id' => $order['medicine_id'],
                'required_quantity' => $order['required_quantity']
            ]);
        }
    }
}
