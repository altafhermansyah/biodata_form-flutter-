<?php
header('Content-Type: application/json');
include "connect.php";

$kode = $_POST['kode'];
$nama = $_POST['nama'];
$harga = $_POST['harga'];
$id = $_POST['id'];

$stmt = $db->prepare("UPDATE items SET kode = ?, nama = ?, harga = ? WHERE id = ?");
$result = $stmt->execute([$kode, $nama, $harga, $id]);

echo json_encode([
    'success' => $result
]);
?>