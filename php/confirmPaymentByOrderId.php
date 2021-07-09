<?php
    include_once("dbconnect.php");
    header('Content-type: application/json');
    $data = json_decode(file_get_contents('php://input'), true);

    $orderId = $data["order_id"];

    $sql = "UPDATE food_order SET payment_made = 1 WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $orderId);
    $response;
    $result = $stmt->execute();
    if ($result) {
        $response = array("success" => true, "data" => null);
    } else {
        $response = array("success" => false, "data" => null);
    }
    echo json_encode($response);
?>
