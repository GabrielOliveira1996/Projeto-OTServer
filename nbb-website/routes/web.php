<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

Route::get('/', [AuthController::class, 'showIndex'])->name('home');
Route::get('/login', fn() => view('auth.login'))->name('login');
Route::post('/login', [AuthController::class, 'login'])->name('login.submit');
Route::get('/register', fn() => view('auth.register'))->name('register');
Route::post('/register', [AuthController::class, 'register'])->name('register.submit');
Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware('auth')->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/character/create', [App\Http\Controllers\PlayerController::class, 'create'])->name('player.create');
    Route::post('/character/create', [App\Http\Controllers\PlayerController::class, 'store'])->name('player.store');
    Route::delete('/character/{player}', [App\Http\Controllers\PlayerController::class, 'destroy'])->name('player.destroy');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/donate', [DonationController::class, 'index'])->name('donate.index');
    Route::post('/donate/checkout', [DonationController::class, 'checkout'])->name('donate.checkout');
});

Route::post('/webhook/abacatepay', [DonationController::class, 'webhook']);