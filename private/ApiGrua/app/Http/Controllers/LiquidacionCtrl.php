<?php

namespace App\Http\Controllers;

use App\Models\Liquidacion;
use Illuminate\Http\Request;

class LiquidacionCtrl extends Controller
{
    /**
    * @OA\Get(
    *     path="/api/liquidaciones",
    *     tags={"Liquidaciones"},
    *     summary="Lista todas las liquidaciones",
    *     @OA\Response(
    *         response=200,
    *         description="OK",
    *         @OA\JsonContent(
    *             type="array",
    *             @OA\Items(ref="#/components/schemas/Liquidacion")
    *         )
    *     )
    * )
    *
    * @OA\Schema(
    *     schema="Liquidacion",
    *     type="object",
    *     @OA\Property(property="id", type="integer"),
    *     @OA\Property(property="retirada_id", type="integer"),
    *     @OA\Property(property="fecha", type="string", format="date"),
    *     @OA\Property(property="importe", type="number", format="float"),
    *     @OA\Property(property="created_at", type="string", format="date-time"),
    *     @OA\Property(property="updated_at", type="string", format="date-time")
    * )
    */
    public function index()
    {
        $liquidaciones = Liquidacion::all();
        return $liquidaciones;
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
        return response()->json([
            'message' => 'Liquidacion creada correctamente',
            'data' => $liquidacion
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $liquidacion = Liquidacion::find($id);
        if (!$liquidacion) {
            return response()->json([
                'message' => 'Liquidacion no encocntrada'
            ], 404);
        }
        return $liquidacion;
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
        if (!$liquidacion) {
            return response()->json([
                'message' => 'Liquidacion no encontrada'
            ], 404);
        }
        $liquidacion->update($request->all());
        return response()->json([
            'message' => 'Liquidacion actualizada correctamente',
            'data' => $liquidacion
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $liquidacion = Liquidacion::find($id);
        if (!$liquidacion) {
            return response()->json([
                'message' => 'Liquidacion no encontrada'
            ], 404);
        }
        $liquidacion->delete();
        return response()->json([
            'message' => 'Liquidacion borrada correctamente'
        ], 200);
    }
}
