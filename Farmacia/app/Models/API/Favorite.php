<?php

namespace App\Models\API;

use App\Models\User;
use App\Models\API\Medicine;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Favorite extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'medicine_id'
    ];

}
