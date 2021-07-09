<?php
    include_once("dbconnect.php");
    header('Content-type: application/json');
    $data = json_decode(file_get_contents('php://input'), true);

    $restaurantId = $data["restaurant_id"];

    $sql = "SELECT * FROM food_order WHERE restaurant_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $restaurantId);
    $response;
    $result = $stmt->execute();
    if ($result) {
        $resultSet = $stmt->get_result();
        $rows = array();
        while ($r = $resultSet->fetch_assoc()) {
            $rows[] = $r;
        }
        $response = array("success" => true, "data" => $rows);
    } else {
        $response = array("success" => false, "data" => null);
    }
    echo json_encode($response);
?>
