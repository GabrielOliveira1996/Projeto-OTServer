<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerSpell extends Model
{
    protected $table = 'player_spells';
    public $incrementing = false; // Chave composta
    protected $primaryKey = ['player_id', 'name'];

    protected $fillable = [
        'player_id', 'name'
    ];

    // Relacionamento: Dono da magia
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}