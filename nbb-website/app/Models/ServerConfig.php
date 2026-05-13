<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServerConfig extends Model
{
    protected $table = 'server_config';
    
    // Informa que a chave primária não é um inteiro incremental e sim a coluna 'config'
    protected $primaryKey = 'config';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'config', 'value'
    ];
}