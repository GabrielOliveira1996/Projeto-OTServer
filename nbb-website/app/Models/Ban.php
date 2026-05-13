<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ban extends Model
{
    protected $fillable = [
        'type', 'value', 'param', 'active', 'expires', 
        'added', 'player_id', 'comment', 'reason', 
        'action', 'statement'
    ];

    // Relacionamento com o GameMaster que baniu
    public function gm()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    // Helper para verificar se o ban ainda é válido
    public function isExpired()
    {
        return now()->timestamp > $this->expires;
    }
}