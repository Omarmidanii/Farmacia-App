<?php

namespace App\Models\API;

use App\Models\API\Medicine;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Classification extends Model
{
    use HasFactory;

    protected $fillable = [
        'name'
    ];
    public function medicine(){
        return $this->hasMany(Medicine::class);
    }
}
