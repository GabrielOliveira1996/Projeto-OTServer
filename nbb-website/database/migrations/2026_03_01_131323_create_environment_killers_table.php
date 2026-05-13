<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('environment_killers', function (Blueprint $table) {
            $table->unsignedBigInteger('kill_id');
            $table->string('name'); // Ex: 'Madara', 'Fire Field', 'Acid'
            
            $table->foreign('kill_id')->references('id')->on('killers')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('environment_killers');
    }
};