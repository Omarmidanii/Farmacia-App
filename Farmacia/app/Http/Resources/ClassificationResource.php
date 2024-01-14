<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClassificationResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return ($request->route()->getName() == "Arabic") ? [
            'id' => $this->id,
            'name' => $this->arabic_name
        ] : [
            'id' => $this->id,
            'name' => $this->name,
        ];
    }
}
