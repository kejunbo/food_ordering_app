<?php
    $servername = "localhost";
    $username = "id17167354_food_ordering_app_kejunbo";
    $password = "$@?fJFJZ(VrXd0di";
    $database = "id17167354_food_ordering_app";
    
    $conn = new mysqli($servername, $username, $password, $database);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
?>