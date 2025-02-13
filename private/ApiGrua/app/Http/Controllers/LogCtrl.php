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
        $logs = Log::getLogs();
        return $logs;
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
            'usuario_id' => 'nullable',
            'descripcion' => 'nullable', // Ajusta las reglas según tus necesidades
            'fecha' => 'nullable',
            'accion' => 'nullable',
        ]);

        // https://laracasts.com/discuss/channels/laravel/validation-problem-the-post-method-is-not-supported-for-route?page=1&replyId=918850

        // Aquí puedes guardar los datos en la base de datos o realizar otras acciones
        // Por ejemplo, guardar en una tabla "logs"
        // Log::create($validatedData);

        // Devolver una respuesta JSON
        return response()->json([
            'message' => 'Solicitud POST recibida',
            'data' => $validatedData,
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
