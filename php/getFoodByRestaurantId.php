<?php
include_once("dbconnect.php");
$data = json_decode(file_get_contents('php://input'), true);
$restaurantId = $data["restaurantId"];

$sql = "SELECT * FROM food WHERE restaurant_id=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $restaurantId);
$stmt->execute();
$resultSet = $stmt->get_result();
$rows = array();
while ($r = $resultSet->fetch_assoc()){
    $rows[] = $r;
}
echo json_encode($rows);
?>