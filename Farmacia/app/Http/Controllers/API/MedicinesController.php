<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ClassificationResource;
use App\Http\Resources\MedicinesResource;
use App\Http\Resources\Orders_MedicinesResource;
use App\Models\API\Medicine;
use App\Models\API\Classification;
use Illuminate\Http\Request;


class MedicinesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $class=ClassificationResource::collection(Classification::all());
        return response()->json([
            'Classifications' => $class
        ]);
    }
    public function showMeds($id){
        $meds = MedicinesResource::collection(Medicine::all()->where('classification_id', $id));
        return response()->json([
            $meds
        ]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {   
        $medicine = Medicine::create([
            'scientific_name'=> $request->scientific_name ,
            'commercial_name' => $request->commercial_name,
            'manufacture_company' => $request->manufacture_company,
            'Available_quantity'=>$request->Available_quantity,
            'Expiration_date'=>$request->Expiration_date,
            'price'=>$request->price,
            'classification_id'=>$request->classification_id,
        ]);
        return response()->json([
            'message' => 'created successfully',
            'medicine' => $medicine,
        ]);
    }

    public function findmed($idc , Request $request){
        $medicine = Medicine::where('classification_id',$idc)->where('commercial_name' , $request->commercial_name)->first();
        if ($medicine) {
            $med = new MedicinesResource($medicine);
            return response()->json($med , 200);
        } else {
            return response()->json(['message' => 'This medicine does not exist'], 404);
        }
    }

    public function show($id){
        $med = Medicine::find($id);
        if($med){
            return response()->json([
                $med
            ] , 200);
        }
        return response()->json([
            "message"=> "Not Found"
        ] , 404);
    }


    public function showall(){
        $meds = MedicinesResource::collection(Medicine::all());
        return response()->json($meds , 200);
    }

}
