<?php
if(isset($_POST['buyukluk'])){
    $deprem = $_POST['buyukluk'];
    
    // Dosyadan JSON verileri oku
  
    
    // Dosyadaki JSON verileri parse et
   

    // Yeni verileri diziye ekle
    $data[] = array("city" => "Istanbul", "value" => (double)$deprem);

    
    // Yeni JSON verilerini dosyaya yaz
    file_put_contents("log.json", json_encode($data));

    // HTTP yanıtı olarak son eklenen deprem büyüklüğünü gönder
    print($deprem);
} else {
    print("no data");
}
?>
