<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tile extends Model
{
    protected $table = 'tiles';

    protected $fillable = [
        'world_id', 'house_id', 'x', 'y', 'z'
    ];

    /**
     * Relacionamento: A qual casa este tile pertence.
     */
    public function house()
    {
        return $this->belongsTo(House::class, 'house_id');
    }
}