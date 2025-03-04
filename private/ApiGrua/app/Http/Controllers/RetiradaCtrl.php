<?php

namespace App\Http\Controllers;

use App\Models\Retirada;
use Illuminate\Http\Request;

class RetiradaCtrl extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $vehiculos = Retirada::all();
        return response()->json($vehiculos, 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $retirada = Retirada::create($request->all());
        return response()->json([
            'message' => 'Retirada creada correctamente',
            'data' => $retirada
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $vehiculos = Retirada::find($id);
        if (!$vehiculos) {
            return response()->json(['message' => 'Retirada no encontrada'], 404);
        }
        return response()->json($vehiculos, 200);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $retirada = Retirada::find($id);
        if (!$retirada) {
            return response()->json(['message' => 'Retirada no encontrada'], 404);
        }
        $retirada->update($request->all());
        return response()->json([
            'message' => 'Retirada actualizada correctamente',
            'data' => $retirada
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $retirada = Retirada::find($id);
        if (!$retirada) {
            return response()->json(['message' => 'Retirada no encontrada'], 404);
        }
        $retirada->delete();
        return response()->json(['message' => 'Retirada eliminada correctamente'], 200);
    }

    /**
     * Get vehicles currently in deposit
     * 
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function getDisponibles()
    {
        $retiradas = Retirada::where('estado', 'En depósito')->get();
        
        return response()->json($retiradas, 200);
    }

    /**
     * Get vehicles currently in deposit
     * 
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function getUltima()
    {
        // Se incluyen los elementos borrados con SoftDeletes
        $ultima_retirada = Retirada::withTrashed()->latest('id')->first();
        
        if ($ultima_retirada) {
            $siguiente_id = $ultima_retirada->id + 1;
            return response()->json(['ultima_retirada' => $ultima_retirada, 'siguiente_id' => $siguiente_id], 200);
        }
        
        return response()->json(['ultima_retirada' => null, 'siguiente_id' => 1], 200);
    }
}
