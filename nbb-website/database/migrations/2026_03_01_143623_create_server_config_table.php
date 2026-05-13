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
        Schema::create('server_config', function (Blueprint $table) {
            // O nome da configuração (ex: db_version)
            $table->string('config', 255)->primary(); 
            
            // O valor da configuração
            $table->string('value', 255); 
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('server_config');
    }
};