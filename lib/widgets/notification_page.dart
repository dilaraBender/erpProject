// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ornek/models/notification_model.dart';
import 'package:ornek/widgets/notification_controller.dart';
import 'package:provider/provider.dart';

// NotificationPage : bildirim sayfası
class NotificationPage extends StatefulWidget {
  final int userId;

  const NotificationPage({super.key, required this.userId});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    Future.microtask(() {
      context.read<NotificationController>().load(widget.userId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bildirimler"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Okunmamış (${controller.unread.length})"),
            Tab(text: "Okunmuş (${controller.read.length})"),
          ],
        ),
      ),
      body: controller.loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildList(controller.unread, controller),
                _buildList(controller.read, controller),
              ],
            ),
    );
  }

  Widget _buildList(
    List<NotificationModel> list,
    NotificationController controller,
  ) {
    if (list.isEmpty) {
      return const Center(child: Text("Bildirim yok"));
    }

    return RefreshIndicator(
      onRefresh: () => controller.load(widget.userId),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            color: item.isRead ? Colors.white : Colors.red.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: Container(
                width: 6,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: item.isRead ? Colors.grey : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
                ),
              ),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(item.body),
                  const SizedBox(height: 6),
                  if (item.createdAt != null)
                    Text(
                      item.createdAt.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),

              trailing: item.isRead
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Icon(Icons.circle, color: Colors.red, size: 12),

              onTap: () async {
                print("TIKLANAN ITEM:");

                print("notId = ${item.notId}");

                print("userId = ${widget.userId}");

                await controller.markAsRead(item.notId, widget.userId);
              },
            ),
          );
        },
      ),
    );
  }
}
