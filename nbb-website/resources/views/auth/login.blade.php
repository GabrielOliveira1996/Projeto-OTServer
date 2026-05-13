@extends('layouts.app')

@section('content')
<div class="max-w-md mx-auto bg-zinc-900 border border-zinc-800 rounded-lg p-8 shadow-2xl">
    <h2 class="text-3xl font-bold text-orange-500 mb-6 text-center">LOGIN</h2>
    @if ($errors->any())
        <div class="mb-4 p-3 bg-red-900/30 border border-red-800 rounded text-red-500 text-sm">
            <ul class="list-none">
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif
    <form action="{{ route('login.submit') }}" method="POST" class="space-y-4">
        @csrf
        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">Conta</label>
            <input type="text" name="name" class="w-full bg-zinc-800 border border-zinc-700 rounded p-2 focus:border-orange-500 outline-none">
        </div>
        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-1">Senha</label>
            <input type="password" name="password" class="w-full bg-zinc-800 border border-zinc-700 rounded p-2 focus:border-orange-500 outline-none">
        </div>
        <button type="submit" class="w-full bg-orange-600 hover:bg-orange-700 text-white font-bold py-2 rounded transition">
            ENTRAR
        </button>
    </form>
</div>
@endsection