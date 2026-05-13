<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Player extends Model
{
    protected $table = 'players';

    public $timestamps = false;

    protected $guarded = [];

    protected $fillable = [
        'name', 
        'world_id', 
        'group_id',
        'account_id', 
        'level', 
        'attribute_points',
        'vocation', 
        'health', 
        'healthmax', 
        'experience',
        'lookbody', 
        'lookfeet', 
        'lookhead', 
        'looklegs',
        'looktype', 
        'lookaddons', 
        'maglevel', 
        'mana', 
        'manamax',
        'manaspent',
        'soul',
        'town_id', 
        'posx', 
        'posy', 
        'posz', 
        'conditions', 
        'cap', 
        'sex',  
        'lastlogin',  
        'lastip',  
        'save',
        'skull',
        'skulltime',
        'rank_id',
        'guildnick',
        'lastlogout',
        'blessings',
        'balance',
        'stamina',
        'direction',
        'loss_experience',
        'loss_mana',
        'loss_skills',
        'loss_containers',
        'loss_items',
        'premend',
        'online',
        'marriage',
        'promotion',
        'deleted',
        'description'
    ];

    public function getVocationNameAttribute()
{
        $vocations = [
            1 => 'Naruto',
            15 => 'Sasuke',
            24 => 'Sakura',
            33  => 'Kiba',
            //53 => 'Hinata',
            //19 => 'Shino',
        ];

        return $vocations[$this->vocation] ?? 'Ninja';
    }

    /**
     * Relacionamento: Cada player pertence a uma única conta.
     */
    public function account(): BelongsTo
    {
        return $this->belongsTo(Account::class, 'account_id', 'id');
    }

    /**
     * Escopo para facilitar a busca por Highscore
     */
    public function scopeHighscore($query)
    {
        return $query->orderBy('level', 'desc')->orderBy('experience', 'desc');
    }
}