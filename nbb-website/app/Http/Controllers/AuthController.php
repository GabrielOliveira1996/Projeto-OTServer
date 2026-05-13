<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Account;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function showIndex() {
        return view('home');
    }

    public function register(Request $request) {
        $request->validate([
            'name'     => 'required|unique:accounts,name|max:32',
            'email'    => 'required|email',
            'password' => 'required|min:8|confirmed', 
        ], [
            'name.unique'       => 'Este nome de conta já está em uso.',
            'name.required'     => 'O nome da conta é obrigatório.',
            'email.email'       => 'Insira um e-mail válido.',
            'password.required' => 'A senha é obrigatória.',
            'password.confirmed' => 'As senhas digitadas não coincidem.',
            'password.min'      => 'A senha deve ter pelo menos 8 caracteres.',
        ]);

        \App\Models\Account::create([
            'name'     => $request->name,
            'password' => sha1($request->password), 
            'email'    => $request->email,
            'group_id' => 1,
            'premdays' => 0, 
        ]);

        return back()->with('success', 'Sua conta foi criada! Agora é só realizar o login.');
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'name' => 'required',
            'password' => 'required',
        ], [
            'name.required'     => 'O campo conta é obrigatório.',
            'password.required' => 'O campo senha é obrigatório.',
        ]);

        // Busca a conta pelo nome (o campo 'name' no seu banco)
        $account = Account::where('name', $credentials['name'])->first();

        // Checagem manual da senha SHA-1
        if ($account && $account->password === sha1($credentials['password'])) {
            Auth::login($account);
            $request->session()->regenerate();

            return redirect()->intended('dashboard');
        }

        return back()->withErrors([
                'name' => 'As credenciais informadas não correspondem aos nossos registros.',
            ])->withInput($request->only('name'));
    }

    public function logout() {
        auth()->logout();
        return redirect()->route('home');
    }
}