<?php

namespace App\Models\API;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'order_state',
        'created_at',
        'expire_at',
        'payment_status',
    ];

    public function Medicines(){
        return $this->belongsToMany(Medicine::class);
    }

    public function user(){
        return $this->belongsTo(User::class);
    }
}
