<?php

namespace App\Http\Controllers\Api;

use App\Models\Log;
use Illuminate\Http\Request;
use App\Http\Requests\LogRequest;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;
use App\Http\Resources\LogResource;

class LogController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $logs = Log::paginate();

        return LogResource::collection($logs);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(LogRequest $request): Log
    {
        return Log::create($request->validated());
    }

    /**
     * Display the specified resource.
     */
    public function show(Log $log): Log
    {
        return $log;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(LogRequest $request, Log $log): Log
    {
        $log->update($request->validated());

        return $log;
    }

    public function destroy(Log $log): Response
    {
        $log->delete();

        return response()->noContent();
    }
}
