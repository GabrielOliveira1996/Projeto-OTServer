<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerNamelock extends Model
{
    protected $table = 'player_namelocks';
    protected $primaryKey = 'player_id';
    public $incrementing = false;

    protected $fillable = [
        'player_id', 'name', 'new_name', 'date'
    ];

    // Relacionamento: Personagem afetado
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}