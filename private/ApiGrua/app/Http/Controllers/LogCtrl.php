<?php

namespace App\Http\Controllers;

use App\Models\Log;
use Exception;
use Illuminate\Http\Request;

class LogCtrl extends Controller
{
    /**
    * @OA\Get(
    *     path="/api/logs",
    *     tags={"Logs"},
    *     summary="Muestra todos los logs",
    *     @OA\Response(
    *         response=200,
    *         description="OK",
    *         @OA\JsonContent(
    *             type="array",
    *             @OA\Items(ref="#/components/schemas/Log")
    *         )
    *     )
    * )
    *
    * @OA\Schema(
    *     schema="Log",
    *     type="object",
    *     @OA\Property(property="id", type="integer"),
    *     @OA\Property(property="usuario_id", type="integer"),
    *     @OA\Property(property="descripcion", type="string"),
    *     @OA\Property(property="accion", type="string"),
    *     @OA\Property(property="created_at", type="string", format="date-time"),
    *     @OA\Property(property="updated_at", type="string", format="date-time")
    * )
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
     * Registra un nuevo log
     * @OA\Post (
     *     path="/api/logs",
     *     tags={"Logs"},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="usuario_id",
     *                          type="integer"
     *                      ),
     *                      @OA\Property(
     *                          property="descripcion",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="accion",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "usuario_id": 1,
     *                     "descripcion": "Login de usuario 1",
     *                     "accion": "LOGIN"
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=201,
     *          description="CREATED",
     *          @OA\JsonContent(
     *              @OA\Property(property="id", type="number", example=1),
     *              @OA\Property(property="usuario_id", type="integer", example=1),
     *              @OA\Property(property="descripcion", type="string", example="User login attempt"),
     *              @OA\Property(property="accion", type="string", example="LOGIN"),
     *              @OA\Property(property="created_at", type="string", example="2023-02-23T00:09:16.000000Z"),
     *              @OA\Property(property="updated_at", type="string", example="2023-02-23T12:33:45.000000Z")
     *          )
     *      ),
     *      @OA\Response(
     *          response=422,
     *          description="Contenido no válido",
     *          @OA\JsonContent(
     *              @OA\Property(property="message", type="string", example="The usuario_id field is required."),
     *              @OA\Property(property="errors", type="string", example="Error object"),
     *          )
     *      )
     * )
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
     * @OA\Get(
     *     path="/api/logs/{id}",
     *     tags={"Logs"},
     *     summary="Obtiene un log específico por ID",
     *     description="Retorna la información detallada de un log específico",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID del log a consultar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Log encontrado exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="id", type="integer"),
     *             @OA\Property(property="usuario_id", type="integer"),
     *             @OA\Property(property="descripcion", type="string"),
     *             @OA\Property(property="accion", type="string"),
     *             @OA\Property(property="created_at", type="string", format="date-time"),
     *             @OA\Property(property="updated_at", type="string", format="date-time")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Log no encontrado",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Log no encontrado")
     *         )
     *     )
     * )
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
