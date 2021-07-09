<?php
include_once("dbconnect.php");
header('Content-type: application/json');
$data = json_decode(file_get_contents('php://input'), true);

$email = $data["email"];
$name = $data["name"];
$password = sha1($data["password"]);

$response;

$sql = "SELECT email from customer WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$result = $stmt->execute();
$resultSet = $stmt->get_result();

if ($resultSet->num_rows) {
    $response = array("success"=> false, "data"=>null, "error"=>"The email already exist, please try again");
} else {
    $sql2 = "INSERT INTO customer (name, email, password) VALUES (?,?,?)";

    $stmt2 = $conn->prepare($sql2);
    $stmt2->bind_param("sss", $name, $email, $password);
    $result2 = $stmt2->execute();
    
    if ($result2) {
        $response = array("success"=> true, "data"=>null);
    } else {
        $response = array("success" => false, "data"=>null);
    }
}

echo json_encode($response);
?>
