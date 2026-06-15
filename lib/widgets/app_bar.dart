import 'package:flutter/material.dart';
import 'package:ornek/login.dart';
import 'package:ornek/widgets/notification_page.dart';
import 'package:ornek/widgets/notification_controller.dart';
import 'package:provider/provider.dart';

// AppBarWidget : ortak AppBar için görünüm

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabBar? tabBar;
  final int? userId;

  const AppBarWidget({super.key, this.tabBar, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationController>();
    final unreadCount = controller.unread.length;

    return AppBar(
      title: Image.asset('resimler/logo.png', height: 40),

      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(userId: userId!),
                  ),
                );
                controller.load(userId!);
              },
              icon: const Icon(Icons.notifications, color: Colors.amber),
            ),

            if (unreadCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    unreadCount > 99 ? "99+" : unreadCount.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
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

      bottom: tabBar,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kToolbarHeight + (tabBar?.preferredSize.height ?? 0),
    );
  }
}
