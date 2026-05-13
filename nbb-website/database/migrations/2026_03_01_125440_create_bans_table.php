<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('bans', function (Blueprint $table) {
            $table->id();
            $table->integer('type'); // 1 para conta, 2 para IP, 3 para personagem
            $table->string('value', 255); // O ID da conta, IP ou Nome baniu
            $table->integer('param')->default(0);
            $table->boolean('active')->default(true);
            $table->bigInteger('expires'); // Timestamp de quando o ban acaba
            $table->bigInteger('added');   // Timestamp de quando foi criado
            
            // Alterado conforme solicitado: Referência ao player (GM)
            $table->unsignedBigInteger('player_id'); 
            $table->foreign('player_id')->references('id')->on('players')->onDelete('cascade');
            
            $table->text('comment')->nullable();
            $table->string('reason', 255)->nullable();
            $table->integer('action')->default(0);
            $table->text('statement')->nullable();
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('bans');
    }
};