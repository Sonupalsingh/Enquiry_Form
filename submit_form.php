<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection details
$host = "localhost";
$username = "sonu";
$password = "sonu"; // Replace with your database password
$database = "TrainingEnquiry";

// Create connection
$conn = new mysqli($host, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve form data
$email = $_POST['email'];
$fullName = $_POST['fullName'];
$contact = $_POST['contact'];
$course = $_POST['course'];
$reference = $_POST['reference'];

// Insert data into the database
$sql = "INSERT INTO Enquiries (email, fullName, contact, course, reference) 
        VALUES ('$email', '$fullName', '$contact', '$course', '$reference')";

if ($conn->query($sql) === TRUE) {
    echo "Thank you! Your enquiry has been submitted successfully.";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Close connection
$conn->close();
?>
