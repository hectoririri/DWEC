<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RetiradaRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
			'id_vehiculos' => 'required|string',
			'nombre' => 'string',
			'nif' => 'string',
			'domicilio' => 'string',
			'poblacion' => 'string',
			'provincia' => 'string',
			'permiso' => 'string',
			'agente' => 'string',
        ];
    }
}
