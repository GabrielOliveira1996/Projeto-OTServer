<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class GlobalStorage extends Model
{
    protected $table = 'global_storage';

    // Importante: Desativa o incremento automático e informa que não temos 'id'
    public $incrementing = false;

    // Define os campos que compõem a chave primária
    protected $primaryKey = ['key', 'world_id'];

    protected $fillable = [
        'key',
        'world_id',
        'value',
    ];

    /**
     * Sobrescreve o comportamento padrão do Eloquent para suportar chaves compostas ao buscar.
     */
    protected function setKeysForSaveQuery($query)
    {
        $query->where('key', '=', $this->getAttribute('key'))
              ->where('world_id', '=', $this->getAttribute('world_id'));
        return $query;
    }
}