<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$foodId = $data["food_id"];
$response = array("success" => false, "data" => null);

$sql = "UPDATE food SET restaurant_id = NULL WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $foodId);
$result = $stmt->execute();
if ($result) {
  $response = array("success" => true, "data" => null);
}
echo json_encode($response);
