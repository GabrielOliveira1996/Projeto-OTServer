<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class House extends Model
{
    protected $fillable = [
        'world_id', 'owner', 'paid', 'warnings', 'lastwarning', 
        'name', 'town', 'size', 'price', 'rent', 'doors', 
        'beds', 'tiles', 'guild', 'clear'
    ];

    // Relacionamento: Quem é o dono da casa
    public function ownerPlayer()
    {
        return $this->belongsTo(Player::class, 'owner');
    }

    // Escopo para filtrar apenas casas de guilda
    public function scopeGuildHouses($query)
    {
        return $query->where('guild', 1);
    }
}