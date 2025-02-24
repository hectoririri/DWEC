<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Illuminate\Http\Request;
use App\Models\Usuario;
use Illuminate\Support\Facades\Validator;

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
        // Crear un nuevo usuario
        $usuario = new Usuario();
        $usuario->email = $request['email'];
        $usuario->rol = $request['rol'];
        $usuario->password = $request['password'];
        // $usuario->password = bcrypt($validatedData['password']); // Encriptar la contraseña
        $usuario->save();

        // Log the created user
        // Log::info('Usuario creado:', $usuario);

        return response()->json(['message' => 'Usuario creado correctamente'], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        return Usuario::find($id);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        // Buscar el usuario por ID
        $usuario = Usuario::find($id);
        if (!$usuario) {
            return response()->json(['message' => 'Usuario no encontrado'], 404);
        }
        // Actualizar
        $usuario->email = $request->input('email');
        $usuario->rol = $request->input('rol');
        $usuario->password = $request->input('password');

        $usuario->save();

        return response()->json($usuario, 200); // Devuelve el usuario actualizado con código 200
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $usuario = Usuario::find($id);
        if (!$usuario) {
            return response()->json(['message' => 'Usuario no encontrado'], 404);
        }
        $usuario->delete();
        return response()->json(['message' => 'Usuario eliminado correctamente'], 200);
    }
}
