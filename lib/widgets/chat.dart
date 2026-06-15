// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ornek/widgets/app_bar.dart';
import '../services/chat_service.dart';

// ChatPage : mesajlaşma ekranı
class ChatPage extends StatefulWidget {
  final int chatRoomId;
  final int userId;

  const ChatPage({super.key, required this.chatRoomId, required this.userId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final ChatService chatService = ChatService();

  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    try {
      await chatService.sendMessage(
        appointmentId: widget.chatRoomId,
        senderId: widget.userId,
        message: messageController.text.trim(),
      );

      messageController.clear();
    } catch (e) {
      print("MESAJ GÖNDERME HATASI: $e");
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: null),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: chatService.getMessages(widget.chatRoomId),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Bir hata oluştu"));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Henüz mesaj yok"));
                }

                final messages = snapshot.data!.docs;

                _scrollToBottom();

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,

                  itemBuilder: (context, index) {
                    final msg = messages[index].data() as Map<String, dynamic>;

                    final isMe = msg["senderId"] == widget.userId;

                    final timestamp = msg["timestamp"];
                    String timeText = "";

                    if (timestamp != null) {
                      timeText = (timestamp as Timestamp)
                          .toDate()
                          .toString()
                          .substring(11, 16);
                    }

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,

                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),

                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),

                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,

                          children: [
                            Text(
                              msg["message"] ?? "",
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              timeText,
                              style: TextStyle(
                                fontSize: 11,
                                color: isMe ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
            ),

            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Mesaj yaz...",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
