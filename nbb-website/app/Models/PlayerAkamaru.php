<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerAkamaru extends Model
{
    protected $table = 'player_akamarus';
    protected $primaryKey = 'player_id';
    public $incrementing = false; // A chave primária é o ID do player

    protected $fillable = [
        'player_id', 
        'level', 
        'exp', 
        'points', 
        'attack', 
        'agility', 
        'dodge', 
        'health_pts', 
        'speed_pts', 
        'current_hp', 
        'is_dead', 
        'death_timestamp', 
        'current_outfit'
    ];

    // Relacionamento: Dono do Akamaru
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}