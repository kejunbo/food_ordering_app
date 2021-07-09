<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$foodId = $data["food_id"];
$name = $data["name"];
$description = $data["description"];
$imageUrl = $data["imageUrl"];
$price = $data["price"];

$response = array("success" => false, "data" => null);
$sql = "UPDATE food SET name = ?, price = ?, description = ?, imageUrl = ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sisss", $name, $price, $description, $imageUrl, $foodId);
$result = $stmt->execute();
// var_dump($stmt->error);
if ($result) {
    $response = array("success" => true, "data" => null);
}
echo json_encode($response);
?>