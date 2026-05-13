<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JobBatch extends Model
{
    protected $table = 'job_batches';
    
    // O ID desta tabela não é um inteiro incremental, mas um UUID/String
    protected $keyType = 'string';
    public $incrementing = false;
    
    public $timestamps = false; // As datas são salvas como inteiros manuais

    protected $fillable = [
        'id', 'name', 'total_jobs', 'pending_jobs', 'failed_jobs', 
        'failed_job_ids', 'options', 'cancelled_at', 'created_at', 'finished_at'
    ];
}