<?php
    include_once("dbconnect.php");
    header('Content-type: application/json');
    $data = json_decode(file_get_contents('php://input'), true);

    $totalPrice = $data["total_price"];
    $address = $data["address"];
    $type = $data["type"];
    $customerId = $data["customer_id"];
    $restaurantId = $data["restaurant_id"];
    $foodList = $data["food_list"];
    $currentTimestamp = round(microtime(true) * 1000);

    $sql = "INSERT INTO food_order (timestamp, total_price, address, type, customer_id, restaurant_id) VALUES (?,?,?,?,?,?)";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssss", $currentTimestamp, $totalPrice, $address, $type, $customerId, $restaurantId);
    $result = $stmt->execute();

    function genarteValueParentheses($firstPlaceholder, $itemList)
    {
        $resultString = array();
        foreach ($itemList as $item) {
            $resultString[] = "(" . $firstPlaceholder . ", ?, ?)";
        }
        return implode(",", $resultString);
    }

    function arrayValue($foodMap)
    {
        return array_values($foodMap);
    }
    
    $response;

    if ($result) {
        $orderId = $stmt->insert_id;
        $sql2 = "INSERT INTO order_item (order_id, food_id, quantity) VALUES " . genarteValueParentheses($orderId, $foodList);
        $stmt2 = $conn->prepare($sql2);
        $finalArr = array_merge(...array_map("arrayValue", $foodList));
        $stmt2->bind_param(str_repeat("ii", sizeof($foodList)), ...$finalArr);
        $success = $stmt2->execute();
        if ($success) {
            $response = array("success" => $success, "data" => null);
        }
    } else {
        $response = array("success" => false, "data" => null);
    }
    echo json_encode($response);
?>