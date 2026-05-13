<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HouseData extends Model
{
    protected $table = 'house_data';

    protected $fillable = [
        'house_id', 
        'world_id', 
        'data'
    ];

    // Relacionamento: A qual casa estes dados pertencem
    public function house()
    {
        return $this->belongsTo(House::class, 'house_id');
    }
}