<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GuildInvite extends Model
{
    protected $table = 'guild_invites';

    // Importante: Desativa o incremento automático e informa que não temos uma chave 'id' única
    public $incrementing = false;

    // Define os campos que compõem a chave primária
    protected $primaryKey = ['player_id', 'guild_id'];

    protected $fillable = [
        'player_id',
        'guild_id',
    ];

    /**
     * Relacionamento: Retorna o jogador que foi convidado.
     */
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    /**
     * Relacionamento: Retorna a guilda que enviou o convite.
     */
    public function guild()
    {
        return $this->belongsTo(Guild::class, 'guild_id');
    }

    /**
     * Sobrescreve o comportamento padrão do Eloquent para suportar chaves compostas ao salvar/deletar.
     */
    protected function setKeysForSaveQuery($query)
    {
        $query->where('player_id', '=', $this->getAttribute('player_id'))
              ->where('guild_id', '=', $this->getAttribute('guild_id'));
        return $query;
    }
}