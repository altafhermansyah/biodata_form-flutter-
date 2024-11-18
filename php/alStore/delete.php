<?php
header('Content-Type: application/json');
include "connect.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM items WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
    'id' => $id,
    'success' => $result
]);
?>