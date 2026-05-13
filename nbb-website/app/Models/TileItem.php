<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TileItem extends Model
{
    protected $table = 'tile_items';

    protected $fillable = [
        'tile_id', 'world_id', 'sid', 'pid', 'itemtype', 'count', 'attributes'
    ];

    // O Laravel trata BLOBs como strings binárias por padrão.
}