<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$customerId = $data["customerId"];
$name = $data["name"];
$email = $data["email"];
$role = $data["role"];

$response;
$sql = "SELECT * from " . $role . " WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$result = $stmt->execute();
$resultSet = $stmt->get_result();
if ($resultSet->num_rows) {
    $r = $resultSet->fetch_assoc();
    if ($r["id"] != $customerId) {
        $response = array("success" => false, "data" => null, "error" => "The email already exist, please try again");
        echo json_encode($response);
        exit();
    }
}

$sql2 = "UPDATE " . $role . " SET name = ?, email = ? WHERE id = ?";

$stmt2 = $conn->prepare($sql2);
$stmt2->bind_param("sss", $name, $email, $customerId);
$result2 = $stmt2->execute();

if ($result2) {
    $response = array("success" => true, "data" => null);
} else {
    $response = array("success" => false, "data" => null);
}

echo json_encode($response);
?>