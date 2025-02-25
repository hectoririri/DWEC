<?php

namespace App\Http\Controllers;

use App\Models\Liquidacion;
use Illuminate\Http\Request;

class LiquidacionCtrl extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Liquidacion::all();
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
        $liquidacion = Liquidacion::create($request->all());
        $liquidacion->retirada->estado = 'Retirado';
        $liquidacion->retirada->fecha_salida = $request->fecha;
        $liquidacion->retirada->save();
        return response()->json(['message' => 'Liquidacion creada correctamente'], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        return Liquidacion::find($id);
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
        $liquidacion = Liquidacion::find($id);
        $liquidacion->update($request->all());
        return response()->json($liquidacion, 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $liquidacion = Liquidacion::find($id);
        $liquidacion->delete();
    }
}
