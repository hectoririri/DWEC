<?php

namespace App\Http\Controllers\Api;

use App\Models\Retirada;
use Illuminate\Http\Request;
use App\Http\Requests\RetiradaRequest;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;
use App\Http\Resources\RetiradaResource;

class RetiradaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $retiradas = Retirada::paginate();

        return RetiradaResource::collection($retiradas);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(RetiradaRequest $request): Retirada
    {
        return Retirada::create($request->validated());
    }

    /**
     * Display the specified resource.
     */
    public function show(Retirada $retirada): Retirada
    {
        return $retirada;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(RetiradaRequest $request, Retirada $retirada): Retirada
    {
        $retirada->update($request->validated());

        return $retirada;
    }

    public function destroy(Retirada $retirada): Response
    {
        $retirada->delete();

        return response()->noContent();
    }
}
