<?php

namespace App\Http\Controllers\Api;

use App\Models\Tarifa;
use Illuminate\Http\Request;
use App\Http\Requests\TarifaRequest;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;
use App\Http\Resources\TarifaResource;

class TarifaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $tarifas = Tarifa::paginate();

        return TarifaResource::collection($tarifas);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(TarifaRequest $request): Tarifa
    {
        return Tarifa::create($request->validated());
    }

    /**
     * Display the specified resource.
     */
    public function show(Tarifa $tarifa): Tarifa
    {
        return $tarifa;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(TarifaRequest $request, Tarifa $tarifa): Tarifa
    {
        $tarifa->update($request->validated());

        return $tarifa;
    }

    public function destroy(Tarifa $tarifa): Response
    {
        $tarifa->delete();

        return response()->noContent();
    }
}
