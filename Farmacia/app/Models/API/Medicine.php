<?php

namespace App\Models\API;


use App\Models\User;
use App\Models\API\Classification;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Medicine extends Model
{
    use HasFactory;
    use SoftDeletes;
    protected $fillable = [
        'scientific_name',
        'commercial_name',
        'manufacture_company',
        'Available_quantity',
        'Expiration_date',
        'price',
        'classification_id',
    ];
    public function orders(){
        return $this->belongsToMany(Order::class);
    }

    public function Classification(){
        return $this->belongsTo(Classification::class);
    }
    
    public function users(){
        return $this->belongsToMany(User::class);
    }

}
