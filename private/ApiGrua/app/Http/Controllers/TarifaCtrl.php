<?php

namespace App\Http\Controllers;

use App\Models\Tarifa;
use Illuminate\Http\Request;

class TarifaCtrl extends Controller
{
    /**
    * @OA\Get(
    *     path="/api/tarifas",
    *     tags={"Tarifas"},
    *     summary="Lista todos las tarifas",
    *     @OA\Response(
    *         response=200,
    *         description="OK",
    *         @OA\JsonContent(
    *             type="array",
    *             @OA\Items(ref="#/components/schemas/Tarifa")
    *         )
    *     )
    * )
    *
    * @OA\Schema(
    *     schema="Tarifa",
    *     type="object",
    *     @OA\Property(property="id", type="integer"),
    *     @OA\Property(property="horas_gratis", type="string"),
    *     @OA\Property(property="costo_por_hora", type="string"),
    * )
    */
    public function index()
    {
        $tarifa = Tarifa::all();
        return $tarifa;
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
        //
    }

    /**
     * @OA\Get(
     *     path="/api/tarifas/{id}",
     *     tags={"Tarifas"},
     *     summary="Obtiene una tarifa específica por ID",
     *     description="Retorna la información detallada de una tarifa específica",
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID de la tarifa a consultar",
     *         @OA\Schema(
     *             type="integer",
     *             format="int64"
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Tarifa encontrada exitosamente",
     *         @OA\JsonContent(
     *             @OA\Property(property="id", type="integer"),
     *             @OA\Property(property="horas_gratis", type="string"),
     *             @OA\Property(property="costo_por_hora", type="string"),
     *             @OA\Property(property="created_at", type="string", format="date-time"),
     *             @OA\Property(property="updated_at", type="string", format="date-time")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Tarifa no encontrada",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Tarifa no encontrada")
     *         )
     *     )
     * )
     */
    public function show(string $id)
    {
        return Tarifa::find($id);
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

    public function getUltima(){
        $tarifa = Tarifa::orderBy('id', 'desc')->first();
        return $tarifa;
    }
}
