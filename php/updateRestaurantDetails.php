<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$restaurantId = $data["restaurant_id"];
$address = $data["address"];
$name = $data["name"];
$description = $data["description"];
$imageUrl = $data["imageUrl"];

$sql = "SELECT * from restaurant WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $restaurantId);
$result = $stmt->execute();
$resultSet = $stmt->get_result();
$response = array("success" => false, "data" => null);
if ($resultSet->num_rows) {
    $sql2 = "UPDATE restaurant SET name = ?, description = ?, address = ?, imageUrl = ? WHERE id = ?";
    $stmt2 = $conn->prepare($sql2);
    $stmt2->bind_param("sssss", $name, $description, $address, $imageUrl, $restaurantId);
    $result2 = $stmt2->execute();
    if ($result2) {
        $response = array("success" => true, "data" => null);
    }
}
echo json_encode($response);
