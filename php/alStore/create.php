<?php
header('Content-Type: application/json');
include "connect.php";

$kode = $_POST['kode'];
$nama = $_POST['nama'];
$harga = $_POST['harga'];

$stmt = $db->prepare("INSERT INTO items (kode, nama, harga) VALUES (?, ?, ?)");
$result = $stmt->execute([$kode, $nama, $harga]);

echo json_encode([
    'success' => $result
]);
?>