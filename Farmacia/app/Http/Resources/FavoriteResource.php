<?php

namespace App\Http\Resources;

use App\Models\API\Medicine;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class FavoriteResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $name = Medicine::where('id',$this->medicine_id)->first();
        return[
            "id" => $this->medicine_id,
            "name" => $name->commercial_name,
            "price" => $name->price
        ];
    }
}
