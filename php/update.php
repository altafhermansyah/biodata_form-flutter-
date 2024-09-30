<?php
header('Content-Type: application/json');
include "konekdb.php";

$name = $_POST['name'];
$birth = $_POST['birth'];
$gender = $_POST['gender'];
$religion = $_POST['religion'];
$address = $_POST['address'];
$id = $_POST['id'];

$stmt = $db->prepare("UPDATE warga SET name = ?, birth = ?, gender = ?, religion = ?, address = ? WHERE id = ?");
$result = $stmt->execute([$name, $birth, $gender, $religion, $address, $id]);

echo json_encode([
    'success' => $result
]);
?>