<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerDepotItem extends Model
{
    protected $table = 'player_depotitems';

    protected $fillable = [
        'player_id', 'sid', 'pid', 'itemtype', 'count', 'attributes'
    ];

    // Relacionamento: Dono do item
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}