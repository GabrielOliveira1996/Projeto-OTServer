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
        if (!Schema::hasTable('accounts')) {
            Schema::create('accounts', function (Blueprint $table) {
                $table->id(); 
                $table->string('name', 32)->unique(); 
                $table->string('password', 40); 
                $table->integer('premdays')->default(0);
                $table->integer('lastday')->default(0);
                $table->string('email', 255)->default('');
                $table->integer('points')->default(0);
                $table->string('key', 20)->default('0');
                $table->boolean('blocked')->default(false);
                $table->integer('warnings')->default(0);
                $table->integer('group_id')->default(1);
                
                // Campos necessários para o Laravel Auth
                $table->rememberToken();
                $table->timestamps();
            });
        } else {
            Schema::table('accounts', function (Blueprint $table) {
                if (!Schema::hasColumn('accounts', 'remember_token')) {
                    $table->rememberToken()->after('group_id');
                }
                if (!Schema::hasColumn('accounts', 'created_at')) {
                    $table->timestamps();
                }
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('accounts');
    }
};