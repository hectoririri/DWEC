<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the posted data
    $data = json_decode(file_get_contents("php://input"), true);

    // Validate the data
    if (isset($data['usuario_id']) && isset($data['accion']) && isset($data['descripcion']) && isset($data['fecha'])) {
        // Here you would typically insert the data into a database
        // For demonstration, we'll just return the received data
        echo json_encode([
            "status" => "success",
            "message" => "Log entry created",
            "data" => $data
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Invalid data"
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Method not allowed"
    ]);
}
?>
