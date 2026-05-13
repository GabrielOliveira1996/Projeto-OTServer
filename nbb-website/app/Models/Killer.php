<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Killer extends Model
{
    protected $table = 'killers';
    public $timestamps = false;

    protected $fillable = ['death_id', 'final_hit', 'unjustified'];

    public function death()
    {
        return $this->belongsTo(PlayerDeath::class, 'death_id');
    }

    // Relacionamento: Se foi um monstro ou campo (Environment)
    public function environment()
    {
        return $this->hasOne(EnvironmentKiller::class, 'kill_id');
    }

    // Se você seguiu minha sugestão de criar 'player_killers' para PvP:
    public function playerKiller()
    {
        return $this->hasOne(PlayerKiller::class, 'kill_id');
    }
}