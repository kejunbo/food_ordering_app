<?php
include_once("dbconnect.php");
$data = json_decode(file_get_contents('php://input'), true);
$email = $data['email'];
$role = $data['role'];
$password = sha1($data['password']);

$stmt = "";
if ($role === "admin") {
    $stmt = $conn->prepare("SELECT * FROM admin WHERE email= ? AND password = ?");
} else if ($role === "customer") {
    $stmt = $conn->prepare("SELECT * FROM customer WHERE email= ? AND password = ?");
}

$stmt->bind_param("ss", $email, $password);
$stmt->execute();
$resultSet = $stmt->get_result();
if ($resultSet->num_rows) {
    $r = $resultSet->fetch_assoc();
    unset($r["password"]);
    if ($role === "admin"){
        $stmt2 = $conn->prepare("SELECT * FROM restaurant WHERE id = ?");
        $stmt2->bind_param("s", $r["restaurant_id"]);
        $stmt2->execute();
        $resultSet = $stmt2->get_result();
        if ($resultSet->num_rows) {
            $r2 = $resultSet->fetch_assoc();
            $r["restaurant"]= $r2;
        }
    }
    $data = array("success"=> true, "data"=>$r);
    echo json_encode($data);
} else {
    $arr = array("success" => false, "data"=>null);
    echo json_encode($arr);
}
