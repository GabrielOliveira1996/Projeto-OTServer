<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerSkill extends Model
{
    protected $table = 'player_skills';
    public $incrementing = false; // Chave composta
    protected $primaryKey = ['player_id', 'skillid'];

    protected $fillable = [
        'player_id', 'skillid', 'value', 'count'
    ];

    // Relacionamento: Dono da skill
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    /**
     * Auxiliar para identificar o nome da skill
     */
    public function getSkillNameAttribute()
    {
        $names = [
            0 => 'Taijutsu',
            1 => 'Melee', 
            2 => 'Sword',
            3 => 'Axe',
            4 => 'Distance',
            5 => 'Shielding',
            6 => 'Fishing'
        ];
        return $names[$this->skillid] ?? 'Unknown';
    }
}