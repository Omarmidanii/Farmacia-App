<?php

namespace App\Models\API;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order_Medicine extends Model
{
    use HasFactory;
    protected $fillable = [
        'order_id',
        'medicine_id',
        'required_quantity'
    ];
    protected $table = 'order_medicine';
}
