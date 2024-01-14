<?php

namespace App\Http\Resources;

use App\Models\API\Medicine;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class Orders_MedicinesResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $name = Medicine::where('id' , $this->medicine_id)->first()->commercial_name;
        return [
            'Medicine_Name' => $name,
            'Required_Quantity' => $this->required_quantity
        ] 
        ;
    }
}
