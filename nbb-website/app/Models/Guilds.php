<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Guild extends Model
{
    protected $fillable = [
        'world_id', 
        'name', 
        'ownerid', 
        'creationdata', 
        'motd'
    ];

    // Relacionamento: Quem é o líder da guilda
    public function owner()
    {
        return $this->belongsTo(Player::class, 'ownerid');
    }

    // Relacionamento: Todos os personagens que pertencem a esta guilda
    // (Isso assume que você tem o campo 'rank_id' ou similar no Player)
    public function members()
    {
        return $this->hasMany(Player::class, 'rank_id'); 
    }
}