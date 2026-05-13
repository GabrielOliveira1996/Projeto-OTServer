<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HouseList extends Model
{
    protected $fillable = [
        'house_id', 
        'world_id', 
        'listid', 
        'list'
    ];

    // Relacionamento: A qual casa esta lista pertence
    public function house()
    {
        return $this->belongsTo(House::class, 'house_id');
    }
}