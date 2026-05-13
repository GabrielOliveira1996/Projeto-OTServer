<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HouseAuction extends Model
{
    protected $table = 'house_auctions';
    public $incrementing = false; // Chave composta
    protected $primaryKey = ['house_id', 'world_id'];

    protected $fillable = [
        'house_id', 'world_id', 'player_id', 'bid', 'limit', 'endtime'
    ];

    // Relacionamento: A qual casa pertence o leilão
    public function house()
    {
        return $this->belongsTo(House::class, 'house_id');
    }

    // Relacionamento: Quem é o licitante atual
    public function bidder()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }
}