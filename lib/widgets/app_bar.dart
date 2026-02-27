import 'package:flutter/material.dart';
import 'package:ornek/login.dart';
import 'package:ornek/widgets/show_message.dart';

// AppBarWidget : ortak AppBar için görünüm

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabBar? tabBar;

  const AppBarWidget({super.key, this.tabBar});

  @override
  Widget build(BuildContext context) {
    // Appbar' da title orta, leaning sol ,action sağ, bottom alt bölümdür
    return AppBar(
      title: Image.asset('resimler/logo.png', height: 40),
      actions: [
        IconButton(
          onPressed: () {
            showMessage(context, 'Güncel bildiriminiz yok.');
          },
          icon: const Icon(Icons.notifications, color: Colors.amber),
        ),

        const SizedBox(width: 5),

        IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          },
          icon: const Icon(Icons.logout, color: Colors.red),
        ),
      ],

      // tabBar varsa bottom olarak ekle
      bottom: tabBar,
    );
  }

  @override
  //appbarın yüksekliği sabit olması için
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (tabBar?.preferredSize.height ?? 0),
    );
  }
}
