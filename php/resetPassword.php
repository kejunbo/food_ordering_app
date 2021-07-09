<?php
    include_once("dbconnect.php");
    header('Content-type: application/json');
    $data = json_decode(file_get_contents('php://input'), true);

    $email = $data["email"];
    $role = $data["role"];
    $password = sha1($data["password"]);

    $response;

    $sql = "SELECT email from " .$role. " WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $result = $stmt->execute();
    $resultSet = $stmt->get_result();

    if ($resultSet->num_rows) {
        $sql2 = "UPDATE " .$role. " SET password = ? WHERE email = ?";

        $stmt2 = $conn->prepare($sql2);
        $stmt2->bind_param("ss", $password, $email);
        $result2 = $stmt2->execute();
        
        if ($result2) {
            $response = array("success"=> true, "data"=>null);
        } else {
            $response = array("success" => false, "data"=>null);
        }
    } else {
        $response = array("success"=> false, "data"=>null, "error"=>"The email does not exist, please try again");
    }

    echo json_encode($response);
?>
