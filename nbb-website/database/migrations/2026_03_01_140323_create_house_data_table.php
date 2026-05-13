<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('house_data', function (Blueprint $table) {
            // Referência à Casa
            $table->unsignedBigInteger('house_id'); 
            $table->foreign('house_id')->references('id')->on('houses')->onDelete('cascade');
            
            $table->integer('world_id')->default(0); // world_id
            
            // Campo para dados binários da casa (Blob)
            $table->binary('data'); 
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('house_data');
    }
};