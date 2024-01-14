<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\ClassificationResource;
use App\Models\API\Classification;
use Illuminate\Http\Request;

class ClassificationsController extends Controller
{
    public function index(){
        $class = ClassificationResource::collection(Classification::all());
        return response()->json($class , 200);
    }
    public function find(Request $request){
        $name  = $request->name;
        $class = Classification::where('name' ,$name)->first();
        if($class)
            return response()->json(new ClassificationResource($class),200);
            return response()->json("Not Found",404);
    }
}
