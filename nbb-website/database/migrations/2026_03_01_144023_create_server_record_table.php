<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('server_record', function (Blueprint $table) {
            // O número recorde de jogadores online
            $table->integer('record')->default(0); 
            
            // O ID do mundo correspondente
            $table->integer('world_id')->default(0); 
            
            // O timestamp de quando o recorde ocorreu
            $table->bigInteger('timestamp')->default(0); 
            
            $table->timestamps();
            
            // Índices para facilitar buscas por mundo e ordenação por data
            $table->index(['world_id', 'timestamp']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('server_record');
    }
};