<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerStorage extends Model
{
    protected $table = 'player_storage';
    public $incrementing = false; // Como usamos chave primária composta
    protected $primaryKey = ['player_id', 'key'];

    protected $fillable = [
        'player_id', 'key', 'value'
    ];

    // Relacionamento: Dono do storage
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}