<?php
    include_once("dbconnect.php");
    header('Content-type: application/json');

    $sql = "SELECT * FROM restaurant";
    $stmt = $conn->prepare($sql);
    $result = $stmt->execute();
    $response;
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
