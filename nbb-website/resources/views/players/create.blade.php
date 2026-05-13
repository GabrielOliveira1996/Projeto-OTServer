@extends('layouts.app')

@section('content')
<div class="max-w-2xl mx-auto bg-zinc-900 border border-zinc-800 rounded-lg p-8 shadow-2xl">
    <h2 class="text-3xl font-bold text-orange-500 mb-6 text-center">NOVO PERSONAGEM</h2>

    <form action="{{ route('player.store') }}" method="POST" class="space-y-6">
        @csrf
        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-2">Nome do Personagem</label>
            <input type="text" name="name" value="{{ old('name') }}" placeholder="Ex: Uzumaki Naruto" 
                   class="w-full bg-zinc-800 border @error('name') border-red-600 @else border-zinc-700 @enderror rounded p-3 focus:border-orange-500 outline-none text-white">
            @error('name') <span class="text-red-500 text-xs font-bold">{{ $message }}</span> @enderror
        </div>

        <div>
            <label class="block text-xs uppercase font-bold text-zinc-500 mb-4">Escolha sua Vocação</label>
            <div class="grid grid-cols-2 gap-4">
                @foreach($vocations as $id => $name)
                <label class="relative cursor-pointer">
                    <input type="radio" name="vocation" value="{{ $id }}" class="peer sr-only" {{ $loop->first ? 'checked' : '' }}>
                    <div class="bg-zinc-800 border border-zinc-700 p-4 rounded-lg text-center peer-checked:border-orange-500 peer-checked:bg-orange-500/10 transition">
                        <span class="block font-bold text-white">{{ $name }}</span>
                    </div>
                </label>
                @endforeach
            </div>
        </div>

        <div class="flex gap-4">
            <a href="{{ route('dashboard') }}" class="flex-1 text-center bg-zinc-800 hover:bg-zinc-700 text-zinc-400 font-bold py-3 rounded transition">VOLTAR</a>
            <button type="submit" class="flex-1 bg-green-600 hover:bg-green-700 text-white font-bold py-3 rounded transition">CRIAR AGORA</button>
        </div>
    </form>
</div>
@endsection