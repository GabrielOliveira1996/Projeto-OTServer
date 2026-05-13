<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EnvironmentKiller extends Model
{
    protected $table = 'environment_killers';
    public $timestamps = false;
    protected $primaryKey = 'kill_id'; // Tabelas de extensão geralmente usam o ID da pai

    protected $fillable = ['kill_id', 'name'];

    public function killer()
    {
        return $this->belongsTo(Killer::class, 'kill_id');
    }
}