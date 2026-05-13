<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServerRecord extends Model
{
    protected $table = 'server_record';

    // Como a tabela não tem uma chave primária 'id', desativamos o incremento
    public $incrementing = false;
    protected $primaryKey = null;

    protected $fillable = [
        'record', 'world_id', 'timestamp'
    ];

    /**
     * Auxiliar para formatar o timestamp em uma data legível
     */
    public function getDateTimeAttribute()
    {
        return \Carbon\Carbon::createFromTimestamp($this->timestamp);
    }
}