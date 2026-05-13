@extends('layouts.app')

@section('content')
<div class="max-w-md mx-auto bg-zinc-900 border border-zinc-800 rounded-lg p-8 shadow-2xl">
    <h2 class="text-3xl font-bold text-orange-500 mb-6 text-center">CADASTRO</h2>

    @if(session('success'))
        <div class="bg-green-600/20 border border-green-600 text-green-500 p-3 rounded mb-4 text-sm font-bold">
            {{ session('success') }}
        </div>
    @endif

    @if($errors->any())
        <div class="bg-red-600/20 border border-red-600 text-red-500 p-3 rounded mb-4 text-sm font-bold">
            Verifique os campos abaixo para continuar.
        </div>
    @endif
    
    <form action="{{ route('register.submit') }}" method="POST" class="space-y-4">
        @csrf
        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">Nome da Conta</label>
            <input type="text" name="name" value="{{ old('name') }}" class="w-full bg-zinc-800 border @error('name') border-red-600 @else border-zinc-700 @enderror rounded p-2 focus:border-green-500 outline-none">
            @error('name')
                <span class="text-red-500 text-xs mt-1 font-semibold">{{ $message }}</span>
            @enderror
        </div>

        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">E-mail</label>
            <input type="email" name="email" value="{{ old('email') }}" class="w-full bg-zinc-800 border @error('email') border-red-600 @else border-zinc-700 @enderror rounded p-2 focus:border-green-500 outline-none">
            @error('email')
                <span class="text-red-500 text-xs mt-1 font-semibold">{{ $message }}</span>
            @enderror
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
                <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">Senha</label>
                <input type="password" name="password" class="w-full bg-zinc-800 border @error('password') border-red-600 @else border-zinc-700 @enderror rounded p-2 focus:border-green-500 outline-none">
            </div>
            <div>
                <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">Confirmar Senha</label>
                <input type="password" name="password_confirmation" class="w-full bg-zinc-800 border border-zinc-700 rounded p-2 focus:border-green-500 outline-none">
            </div>
        </div>
        @error('password')
            <span class="text-red-500 text-xs mt-1 font-semibold">{{ $message }}</span>
        @enderror

        <button type="submit" class="w-full bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 rounded transition mt-4">
            CRIAR MINHA JORNADA
        </button>
    </form>
</div>
@endsection