<?php

namespace App\Http\Controllers\Api;

use App\Models\Vehiculo;
use Illuminate\Http\Request;
use App\Http\Requests\VehiculoRequest;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;
use App\Http\Resources\VehiculoResource;

class VehiculoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $vehiculos = Vehiculo::paginate();

        return VehiculoResource::collection($vehiculos);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(VehiculoRequest $request): Vehiculo
    {
        return Vehiculo::create($request->validated());
    }

    /**
     * Display the specified resource.
     */
    public function show(Vehiculo $vehiculo): Vehiculo
    {
        return $vehiculo;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(VehiculoRequest $request, Vehiculo $vehiculo): Vehiculo
    {
        $vehiculo->update($request->validated());

        return $vehiculo;
    }

    public function destroy(Vehiculo $vehiculo): Response
    {
        $vehiculo->delete();

        return response()->noContent();
    }
}
