<?php

namespace App\Http\Resources;

use App\Models\API\Favorite;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MedicinesResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request)
    {
        if($request->route()->getName() == "show_all_medicines"){
            return ['id'=>$this->id ,'name'=>$this->commercial_name];
        }
        $favorite = Favorite::where('medicine_id' , $this->id)->get()->first();
        if($favorite)$is_favorite = true;
        else $is_favorite = false;
        return [
            'id' => $this->id,
            'price' => $this->price,
            'commercial_name' => $this->commercial_name,
            'is_favorite' => $is_favorite
        ];
    }
}
