<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\Orders_MedicinesResource;
use App\Models\API\Order;
use App\Models\API\Medicine;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\OrdersResource;
use App\Models\API\Order_Medicine;
use App\Models\User;

class OrdersController extends Controller
{
   
    public function index(Request $request , $lang){
       if($request->user()->Is_admin == 1){
        $orders = OrdersResource::collection(Order::all());
       }else{
        $Order = Order::where('user_id' , $request->user()->id)->get();
        OrdersResource::$lang = $lang;
        $orders = OrdersResource::collection($Order);
       }
        return response()->json($orders,200);
    }
    public function create(Request $request){
        
        if($request->meds == null){
            return response()->json("null",500);
        }
        foreach($request->meds as $med){
            $Med = Medicine::where('id' , $med['med_id'])->first();
            if($Med->Available_quantity < $med['quantity']){
                    return response()->json([
                        $Med->commercial_name => 'The Quantity Is Not Available'
                    ] , 403);
            }
        }
        $order = Order::create([
            'user_id' => $request->user()->id,
        ]);
        $id = $order->id;
        foreach($request->meds as $med){
            Order_Medicine::create([
                'order_id' => $id,
                'medicine_id'=>$med['med_id'],
                'required_quantity'=>$med['quantity']
            ]);
        }
        return response()->json([
            "Order created successfully",
            $order
        ] , 200);
    }

    public function show($id , Request $request){
        $items = Orders_MedicinesResource::collection(Order_Medicine::where('order_id' , $id)->get());
        if($request->user()->Is_admin == 1){
            $orders = new OrdersResource(Order::find($id));
          return   response()->json([$orders,$items] , 200);
           }
        return response()->json($items,200);
    }
    public function set_state(Request $request){
        if($request->user()->Is_admin == 1){
            if($request->state == 1){
                $order = Order::find($request->id);
                if($order->order_state != 'preparing')
                {
                    return response()->json(['message' => 'Action Denied'] , 403 );
                }
                $order->update([$order->order_state = 'has been sent']);
                $order_meds = Order_Medicine::where('order_id' , $request->id)->get();
                foreach($order_meds as $med){
                    $Med = Medicine::find($med->medicine_id);
                    $Med->update([$Med->Available_quantity -= $med->required_quantity]);
                }
                return response()->json(['message' => 'Order-State changed successfully'] , 200);
            }

            else if($request->state == 2){
                $order = Order::find($request->id);
                if($order->order_state != 'has been sent')
                {
                    return response()->json([
                        'message' => 'Action Denied'
                    ] , 403);
                }
                $order->update([$order->order_state = 'recived']);
                return response()->json([
                    'message' => 'Order-State changed successfully'
                ] , 200);
            }
            return response()->json([
                'message' => 'Invalid Input'
            ] , 400);

        }
        return response()->json([
            'message' => 'Unauthorized'
        ] , 401);
    }
    public function set_payment(Request $request){
        if($request->user()->Is_admin == 1){
            if($request->paid == 0){
                $order = Order::find($request->id);
                $order->update([$order->payment_status = 'Unpaid']);
                return response()->json([
                    'message' => 'Payment-Status changed successfully'
                ] , 200);
            }
            else if($request->paid == 1){
                $order = Order::find($request->id);
                $order->update([$order->payment_status = 'paid']);
                return response()->json([
                    'message' => 'Payment-Status changed successfully'
                ], 200);
            }
            return response()->json([
                'message' => 'Invalid Input'
            ] , 400);
        }
        return response()->json([
            'message' => 'Unauthorized'
        ], 401);
    }
}
