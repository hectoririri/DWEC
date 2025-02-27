<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Illuminate\Http\Request;

class LogCtrl extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $logs = Log::all();

        return response()->json([
            'logs' => $logs
        ]);
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
        // Validar los datos enviados
        $validatedData = $request->validate([
            'usuario_id' => 'nullable|integer',
            'descripcion' => 'nullable|string',
            'accion' => 'nullable|string',
        ]);

        // Crear un nuevo registro en la base de datos
        $log = Log::create($validatedData);

        // Devolver una respuesta JSON
        return response()->json([
            'message' => 'Registro creado exitosamente',
            'data' => $log,
        ], 201); // Código de estado 201 (Created)
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
