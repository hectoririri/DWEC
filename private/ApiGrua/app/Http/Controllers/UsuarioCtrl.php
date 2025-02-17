<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Illuminate\Http\Request;
use App\Models\Usuario;

class UsuarioCtrl extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $usuarios = Usuario::all();
        return $usuarios;
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
        // Validación de datos
        $validatedData = $request->validate([
            'email' => 'required|email|max:255',
            'password' => 'required|string|min:6',
        ]);

        // Crear un nuevo registro
        $usuario = Usuario::create($validatedData);

        return response()->json($usuario, 201); // Devuelve el usuario creado con código 201
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
