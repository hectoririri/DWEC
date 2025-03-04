<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Exception;
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
        ], 200); // Status code 200 (OK)
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
        try {
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

        } catch (Exception $e) {
            // Si la creación falla..
            return response()->json([
                'message' => 'Error al crear el registro',
                'error' => $e->getMessage()
            ], 500); // Código de estado 500 (Internal Server Error)
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        try {
            $log = Log::find($id);

            // Devuelve la entrada y mensaje de confirmacion si existe
            return response()->json([
                'message' => 'Entrada de log encontrada',
                'data' => $log
            ], 200); // Código de estado 200 (OK)

        } catch (Exception $e) {
            // Error si la entrada no existe
            return response()->json([
                'message' => 'No se ha encontrado la entrada de log',
                'error' => $e->getMessage()
            ], 404); // Código de estado 404 (Not Found)
        }
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
