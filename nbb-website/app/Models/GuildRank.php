<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GuildRank extends Model
{
    protected $fillable = ['guild_id', 'name', 'level'];

    // Relacionamento: A qual guilda este cargo pertence
    public function guild()
    {
        return $this->belongsTo(Guild::class, 'guild_id');
    }

    // Relacionamento: Jogadores que possuem este cargo específico
    public function members()
    {
        return $this->hasMany(Player::class, 'rank_id');
    }
}