<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Account extends Authenticatable
{
    use Notifiable;

    protected $table = 'accounts';
    public $timestamps = false; 

    protected $fillable = [
        'name', 
        'password', 
        'email', 
        'premdays', 
        'group_id',
        'points',
    ];

    protected $hidden = [
        'password', 
        'remember_token',
        'key' 
    ];

    public function getAuthPassword()
    {
        return $this->password;
    }

    /**
     * Relaciona a conta com os personagens
     */
    public function players(): HasMany
{
    // Retorna apenas personagens que NÃO foram deletados
    return $this->hasMany(Player::class, 'account_id', 'id')->where('deleted', 0);
}
}