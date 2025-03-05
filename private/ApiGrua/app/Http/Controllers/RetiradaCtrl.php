<?php

namespace App\Http\Controllers;

use App\Models\Retirada;
use Illuminate\Http\Request;

class RetiradaCtrl extends Controller
{
    /**
    * @OA\Get(
    *     path="/api/retiradas",
    *     tags={"Retiradas"},
    *     summary="Lista todas las retiradas",
    *     @OA\Response(
    *         response=200,
    *         description="OK",
    *         @OA\JsonContent(
    *             type="array",
    *             @OA\Items(ref="#/components/schemas/Retirada")
    *         )
    *     )
    * )
    *
    * @OA\Schema(
    *     schema="Retirada",
    *     type="object",
    *     @OA\Property(property="lugar", type="string"),
    *     @OA\Property(property="direccion", type="string"),
    *     @OA\Property(property="agente", type="string"),
    *     @OA\Property(property="matricula", type="string"),
    *     @OA\Property(property="marca", type="string"),
    *     @OA\Property(property="modelo", type="string"),
    *     @OA\Property(property="color", type="string"),
    *     @OA\Property(property="motivo", type="string"),
    *     @OA\Property(property="tipo_vehiculo", type="string"),
    *     @OA\Property(property="grua", type="string"),
    *     @OA\Property(property="estado", type="string"),
    * )
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
     * @OA\Post(
     *     path="/api/retiradas",
     *     tags={"Retiradas"},
     *     summary="Crea una nueva retirada",
     *     description="Crea un nuevo registro de retirada de vehículo",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="lugar", type="string"),
     *             @OA\Property(property="direccion", type="string"),
     *             @OA\Property(property="agente", type="string"),
     *             @OA\Property(property="matricula", type="string"),
     *             @OA\Property(property="marca", type="string"),
     *             @OA\Property(property="modelo", type="string"),
     *             @OA\Property(property="color", type="string"),
     *             @OA\Property(property="motivo", type="string"),
     *             @OA\Property(property="tipo_vehiculo", type="string"),
     *             @OA\Property(property="grua", type="string"),
     *             @OA\Property(property="estado", type="string"),
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Retirada creada exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada creada correctamente"),
     *             @OA\Property(
     *                 property="data",
     *                 ref="#/components/schemas/Retirada"
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
        $retirada = Retirada::create($request->all());
        return response()->json([
            'message' => 'Retirada creada correctamente',
            'data' => $retirada
        ], 201);
    }

    /**
     * @OA\Get(
     *     path="/api/retiradas/{id}",
     *     tags={"Retiradas"},
     *     summary="Obtiene una retirada específica por ID",
     *     description="Retorna la información detallada de una retirada específica",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID de la retirada a consultar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Retirada encontrada exitosamente",
     *         @OA\JsonContent(ref="#/components/schemas/Retirada")
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Retirada no encontrada",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada no encontrada")
     *         )
     *     )
     * )
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
     * @OA\Put(
     *     path="/api/retiradas/{id}",
     *     tags={"Retiradas"},
     *     summary="Actualiza una retirada específica",
     *     description="Actualiza la información de una retirada existente",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID de la retirada a actualizar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="lugar", type="string"),
     *             @OA\Property(property="direccion", type="string"),
     *             @OA\Property(property="agente", type="string"),
     *             @OA\Property(property="matricula", type="string"),
     *             @OA\Property(property="marca", type="string"),
     *             @OA\Property(property="modelo", type="string"),
     *             @OA\Property(property="color", type="string"),
     *             @OA\Property(property="motivo", type="string"),
     *             @OA\Property(property="tipo_vehiculo", type="string"),
     *             @OA\Property(property="grua", type="string"),
     *             @OA\Property(property="estado", type="string"),
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Retirada actualizada exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada actualizada correctamente"),
     *             @OA\Property(property="data", ref="#/components/schemas/Retirada")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Retirada no encontrada",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada no encontrada")
     *         )
     *     )
     * )
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
     * @OA\Delete(
     *     path="/api/retiradas/{id}",
     *     tags={"Retiradas"},
     *     summary="Elimina una retirada específica",
     *     description="Elimina un registro de retirada existente",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID de la retirada a eliminar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Retirada eliminada exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada eliminada correctamente")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Retirada no encontrada",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Retirada no encontrada")
     *         )
     *     )
     * )
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
     * @OA\Get(
     *     path="/api/retiradas/deposito",
     *     tags={"Retiradas"},
     *     summary="Obtiene todas las retiradas en depósito",
     *     description="Retorna la lista de vehículos que actualmente están en el depósito",
     *     @OA\Response(
     *         response=200,
     *         description="Lista de retiradas en depósito obtenida exitosamente",
     *         @OA\JsonContent(
     *             type="array",
     *             @OA\Items(ref="#/components/schemas/Retirada")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="No hay vehículos en depósito",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="No hay vehículos en depósito")
     *         )
     *     )
     * )
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
