<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">

  </head>
  <body>
    <h1>Deprem Ölçer Sistemi</h1>

    Bu proje, Swift ve PHP programlama dilleri ile JSON veri formatını kullanarak bir deprem ölçer sistemi oluşturmayı amaçlamaktadır. Bu sistem, çeşitli deprem sensörlerinden alınan verileri toplayacak ve kullanıcıların deprem bilgilerini takip etmelerine olanak tanıyacaktır.

   Nasıl Çalışır?

    Bu sistem, sensörler tarafından sağlanan verileri almak ve işlemek için bir web sunucusu kullanacaktır. Sunucu, verileri işlemek ve saklamak için bir veritabanı kullanacak ve kullanıcıların deprem bilgilerini görüntülemelerine olanak tanıyacak bir web arayüzü sağlayacaktır.

    Sensörler, deprem ölçümlerini yapmak için birçok farklı yöntem kullanabilirler. Bu proje için, sensörlerin deprem dalgalarını algılamak için yaygın olarak kullanılan bir yöntem olan "piezoelektrik sensörler" kullanılacaktır. Bu sensörler, deprem dalgaları tarafından üretilen elektrik sinyallerini algılayarak deprem ölçümlerini yaparlar.

    Veriler, sensörler tarafından toplandıktan sonra JSON formatında sunucuya gönderilecektir. Sunucu, bu verileri alacak, işleyecek ve bir veritabanına kaydedecektir. Bu veritabanı, kullanıcılara deprem bilgilerini görüntülemek için kullanılacaktır.

    Proje Yapısı

    Bu projenin genel yapısı şu şekildedir:

    
Sensörler: Bu bölüm, deprem ölçümlerini yapmak için kullanılacak sensörlerin tasarımını ve yapısını açıklar.
Swift İstemci Uygulaması:</strong> Bu bölüm, kullanıcıların deprem bilgilerini görüntülemelerine olanak tanıyan bir iOS uygulaması oluşturmayı açıklar. Bu uygulama, sunucudan JSON verilerini alacak ve kullanıcılara deprem bilgilerini gösterecektir.
PHP Sunucu Uygulaması: Bu bölüm, verileri işlemek ve saklamak için bir web sunucusu oluşturmayı açıklar. Sunucu, gelen JSON veriler
