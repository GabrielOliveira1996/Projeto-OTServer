<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerAkamaruOutfit extends Model
{
    protected $table = 'player_akamaru_outfits';
    public $timestamps = false;
    protected $primaryKey = ['player_id', 'outfit_id'];
    public $incrementing = false;

    protected $fillable = ['player_id', 'outfit_id'];
}