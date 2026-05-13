<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FailedJob extends Model
{
    // Define explicitamente o nome da tabela
    protected $table = 'failed_jobs';

    public $timestamps = false;

    // Campos que podem ser preenchidos em massa
    protected $fillable = [
        'uuid',
        'connection',
        'queue',
        'payload',
        'exception',
        'failed_at',
    ];

    // Trata o campo 'failed_at' como um objeto de data (Carbon)
    protected $casts = [
        'failed_at' => 'datetime',
    ];
}