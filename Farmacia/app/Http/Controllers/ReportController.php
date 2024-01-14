<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\API\Order;
use App\Models\API\Medicine;
use Illuminate\Http\Request;
use App\Http\Resources\OrdersResource;
use App\Http\Resources\MedicinesResource;
use App\Http\Resources\Orders_MedicinesResource;
use App\Models\API\Order_Medicine;
use App\Models\User;

class ReportController extends Controller
{
    public function FirstReport(){
        if(!auth()->user()->Is_admin){
            return response()->json('Unauthorised' , 403);
        }
        $Order = ( OrdersResource::collection(Order::where('created_at' , '>' , Carbon::now()->subDays(30))->get()))->resolve();
        $Report = ['Profits' => 0 , 'Quantity_of_medication' => 0 , 'Number_Of_Users' => 0 , 'Number_Of_Orders' => 0];
        foreach($Order as $order){
            $Report['Profits'] += $order['Total_Price'];
            $items = (Orders_MedicinesResource::collection(Order_Medicine::where('order_id' , $order['Order_Id'])->get()))->resolve();
            foreach($items as $med){
                $Report['Quantity_of_medication'] += $med['Required_Quantity'];
            }
        } 
        $Report['Number_Of_Orders'] = count($Order);
        $Users = User::where('created_at' , '>' , Carbon::now()->subDays(30))->get();
        $Report['Number_Of_Users'] = count($Users);
        return response()->json($Report , 200);
    }

    public function SecondReport(){
        $Order = ( OrdersResource::collection(Order::where('created_at' , '>' , Carbon::now()->subDays(180))->get()))->resolve();
        $Report = ['Profits' => 0 , 'Quantity_of_medication' => 0 , 'Number_Of_Users' => 0 , 'Number_Of_Orders' => 0];
        foreach($Order as $order){
            $Report['Profits'] += $order['Total_Price'];
            $items = (Orders_MedicinesResource::collection(Order_Medicine::where('order_id' , $order['Order_Id'])->get()))->resolve();
            foreach($items as $med){
                $Report['Quantity_of_medication'] += $med['Required_Quantity'];
            }
        } 
        $Report['Number_Of_Orders'] = count($Order);
        $Users = User::where('created_at' , '>' , Carbon::now()->subDays(30))->get();
        $Report['Number_Of_Users'] = count($Users);
        return response()->json($Report , 200);
    }
}
