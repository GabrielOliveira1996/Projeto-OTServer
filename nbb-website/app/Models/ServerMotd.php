<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ServerMotd extends Model
{
    protected $table = 'server_motd';

    protected $fillable = [
        'world_id', 'text'
    ];
}