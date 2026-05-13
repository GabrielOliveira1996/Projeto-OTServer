<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerVip extends Model
{
    protected $table = 'player_viplist';
    public $incrementing = false;
    protected $primaryKey = ['player_id', 'vip_id'];

    protected $fillable = [
        'player_id', 'vip_id'
    ];

    // Relacionamento: Quem é o dono desta entrada na lista
    public function owner()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    // Relacionamento: Quem é o amigo adicionado
    public function friend()
    {
        return $this->belongsTo(Player::class, 'vip_id');
    }
}