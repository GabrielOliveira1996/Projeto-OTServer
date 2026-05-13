<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AccountViplist extends Model
{
    // Define o nome exato da tabela conforme o seu banco
    protected $table = 'account_viplist';

    // Como não usamos 'id' auto-incremental padrão
    public $incrementing = false;
    protected $primaryKey = ['account_id', 'player_id'];

    protected $fillable = [
        'account_id',
        'world_id',
        'player_id'
    ];

    // Relacionamento com a Conta
    public function account()
    {
        return $this->belongsTo(Account::class, 'account_id');
    }
}