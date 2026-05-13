<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerItem extends Model
{
    protected $table = 'player_items';

    protected $fillable = [
        'player_id', 'pid', 'sid', 'itemtype', 'count', 'attributes'
    ];

    // Relacionamento: Dono do item
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}