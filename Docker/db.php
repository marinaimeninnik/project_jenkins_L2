<?php
session_start();

$conn = mysqli_connect(
  'mysql',
  'root',
  'password123',
  'php_mysql_crud'
) or die(mysqli_error($conn));

?>
