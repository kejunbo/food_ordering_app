<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$name = $data["name"];
$description = $data["description"];
$imageUrl = $data["imageUrl"];
$price = $data["price"];
$restaurantId = $data["restaurant_id"];

$response = array("success" => false, "data" => null);
$sql = "INSERT INTO food (name, price, description, restaurant_id, imageUrl) VALUES (?,?,?,?,?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sisss", $name, $price, $description, $restaurantId, $imageUrl);
$result = $stmt->execute();
// var_dump($stmt->error);
if ($result) {
    $response = array("success" => true, "data" => null);
}
echo json_encode($response);
?>