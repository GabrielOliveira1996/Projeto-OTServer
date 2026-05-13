<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerDeath extends Model
{
    protected $table = 'player_deaths';
    public $timestamps = false; // OTs costumam usar apenas o campo 'date'

    protected $fillable = ['player_id', 'date', 'level'];

    // Relacionamento: Quem morreu
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    // Relacionamento: Lista de quem participou da morte
    public function killers()
    {
        return $this->hasMany(Killer::class, 'death_id');
    }
}