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
        $usuario = Usuario::find($request->input('email'));
        if ($usuario) {
            return response()->json(['message' => 'Usuario ya existente'], 404);
        }

        // Validar los datos recibidos
        // $validator = Validator::make($request->all(), [
        //     'email' => 'required|email|unique:usuarios,email,' . $id,
        //     'rol' => 'required|in:administrador,usuario',
        //     'password' => 'nullable|min:6', // Opcional, solo si se desea cambiar la contraseña
        // ]);

        // if ($validator->fails()) {
        //     return response()->json(['errors' => $validator->errors()], 422);
        // }

        // Actualizar el usuario
        $usuario->email = $request->input('email');
        $usuario->rol = $request->input('rol');
        $usuario->password = $request->input('password');

        $usuario->create();

        return response()->json($usuario, 200); // Devuelve el usuario actualizado con código 200
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

        // Validar los datos recibidos
        // $validator = Validator::make($request->all(), [
        //     'email' => 'required|email|unique:usuarios,email,' . $id,
        //     'rol' => 'required|in:administrador,usuario',
        //     'password' => 'nullable|min:6', // Opcional, solo si se desea cambiar la contraseña
        // ]);

        // if ($validator->fails()) {
        //     return response()->json(['errors' => $validator->errors()], 422);
        // }

        // Actualizar el usuario
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
