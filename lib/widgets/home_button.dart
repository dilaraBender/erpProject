import 'package:flutter/material.dart';

// homeButton : menüler için buton görünümleri

// neden Widget kullanıyoruz?
// Arayüzde sık kullanılan bileşenler, kod karmaşıklığını önlemek ve yeniden kullanılabilirliği sağlamak amacıyla
// ayrı widget’lar olarak tasarlanmıştır. Bu yapı sayesinde aynı görünüm, farklı parametrelerle tekrar kullanılabilmektedir.
Widget homeButton({
  // değişkenlerimiz
  required IconData icon,
  required String title,
  required Color color,
  required VoidCallback func,
}) {
  // fiziksel olarak kart,davranışsal olarak buton gibi yapı için InkWell kullanıyoruz
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    // tıklandıgında çalışacak fonk.
    onTap: func,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon,color ve title bilgilerini çağrıldığı yerden alacak ve burada kullanacagız
          Icon(icon, size: 40, color: color),
          SizedBox(width: 20),
          Text(title),
        ],
      ),
    ),
  );
}
