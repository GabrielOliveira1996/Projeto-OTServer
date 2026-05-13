<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServerReport extends Model
{
    protected $table = 'server_reports';

    protected $fillable = [
        'world_id', 'player_id', 'posx', 'posy', 'posz', 'timestamp', 'report', 'reads'
    ];

    // Relacionamento: Quem enviou o report
    public function player()
    {
        return $this->belongsTo(Player::class, 'player_id');
    }

    // Helper para verificar se já foi atendido
    public function isRead()
    {
        return $this->reads > 0;
    }
}