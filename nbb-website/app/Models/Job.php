<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    protected $table = 'jobs';
    public $timestamps = false; // Os campos de data aqui são timestamps manuais (inteiros)

    protected $fillable = [
        'queue', 'payload', 'attempts', 'reserved_at', 'available_at', 'created_at'
    ];
}