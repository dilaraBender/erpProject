import 'package:flutter/material.dart';

// showMessage : SnackBar ile mesaj göstermek için kullanılan ortak fonk.

// ÇOğu yerde kullanacağımız için snackBar göstermeyi bir fonksiyon olarak oluşturup ilgili yerlerde çağıracağız.
// neden widget değil de bir fonksiyon yaptık çünkü widgetler UI içindir fonksiyonlar tetiklenme vs. gibi işlemlerde tercih edilir.
void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.blueGrey),
  );
}
