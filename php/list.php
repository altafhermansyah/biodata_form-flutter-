<?php
header('Content-Type: application/json');
include "konekdb.php";

$stmt = $db->prepare("SELECT id, name, gender, birth, religion, address FROM warga");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>