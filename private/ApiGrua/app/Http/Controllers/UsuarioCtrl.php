<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Usuario;

/**
* @OA\Info(
*             title="API Grua Laravel", 
*             version="1.0",
*             description="Api de Grua para proyecto DWEC. Vue + Laravel"
* )
*
* @OA\Server(url="http://localhost/DWEC/private/ApiGrua/public/")
*/

class UsuarioCtrl extends Controller
{

    /**
    * @OA\Get(
    *     path="/api/usuarios",
    *     tags={"Usuario"},
    *     summary="Lista todos los usuarios",
    *     @OA\Response(
    *         response=200,
    *         description="OK",
    *         @OA\JsonContent(
    *             type="array",
    *             @OA\Items(ref="#/components/schemas/Usuario")
    *         )
    *     )
    * )
    *
    * @OA\Schema(
    *     schema="Usuario",
    *     type="object",
    *     @OA\Property(property="id", type="integer"),
    *     @OA\Property(property="email", type="string"),
    *     @OA\Property(property="password", type="string"),
    *     @OA\Property(property="rol", type="string"),
    *     @OA\Property(property="created_at", type="string", format="date-time"),
    *     @OA\Property(property="updated_at", type="string", format="date-time")
    * )
    */
    public function index()
    {
        $usuarios = Usuario::all();
        return $usuarios;
    }

    /**
     * @OA\Get(
     *     path="/api/usuarios/{id}",
     *     tags={"Usuario"},
     *     summary="Obtiene un usuario específico por ID",
     *     description="Retorna la información detallada de un usuario específico",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID del usuario a consultar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Usuario encontrado exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="id", type="integer"),
     *             @OA\Property(property="email", type="string"),
     *             @OA\Property(property="rol", type="string"),
     *             @OA\Property(property="created_at", type="string", format="date-time"),
     *             @OA\Property(property="updated_at", type="string", format="date-time")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Usuario no encontrado",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Usuario no encontrado")
     *         )
     *     )
     * )
     */
    public function show($id)
    {
    $usuario = Usuario::find($id);
    if (!$usuario) {
        return response()->json(['message' => 'Usuario no encontrado'], 404);
    }
    return response()->json($usuario, 200);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * @OA\Post(
     *     path="/api/usuarios",
     *     tags={"Usuario"},
     *     summary="Crea un nuevo usuario",
     *     description="Crea un nuevo usuario en el sistema",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="email", type="string", format="email"),
     *             @OA\Property(property="password", type="string"),
     *             @OA\Property(property="rol", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Usuario creado exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Usuario creado correctamente"),
     *             @OA\Property(property="usuario", type="object",
     *                 @OA\Property(property="id", type="integer"),
     *                 @OA\Property(property="email", type="string"),
     *                 @OA\Property(property="rol", type="string"),
     *                 @OA\Property(property="created_at", type="string", format="date-time"),
     *                 @OA\Property(property="updated_at", type="string", format="date-time")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Error de validación",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Error de validación"),
     *             @OA\Property(property="errors", type="object")
     *         )
     *     )
     * )
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
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        
    }

    /**
     * Update user information
     * @OA\Put (
     *     path="/api/usuarios/{id}",
     *     tags={"Usuario"},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="email",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="rol",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "email": "user@example.com",
     *                     "password": "newpassword123",
     *                     "rol": "admin"
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *              @OA\Property(property="id", type="number", example=1),
     *              @OA\Property(property="email", type="string", example="user@example.com"),
     *              @OA\Property(property="rol", type="string", example="admin"),
     *              @OA\Property(property="created_at", type="string", example="2023-02-23T00:09:16.000000Z"),
     *              @OA\Property(property="updated_at", type="string", example="2023-02-23T12:33:45.000000Z")
     *          )
     *      ),
     *      @OA\Response(
     *          response=404,
     *          description="User not found"
     *      ),
     *      @OA\Response(
     *          response=422,
     *          description="UNPROCESSABLE CONTENT",
     *          @OA\JsonContent(
     *              @OA\Property(property="message", type="string", example="The email field is required."),
     *              @OA\Property(property="errors", type="object", example={"email": {"The email field is required."}})
     *          )
     *      )
     * )
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
     * Delete user information
     * @OA\Delete (
     *     path="/api/usuarios/{id}",
     *     tags={"Usuario"},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Success",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Usuario eliminado correctamente")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="NOT FOUND",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Usuario no encontrado")
     *         )
     *     )
     * )
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
