// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_user.dart';
import 'package:ornek/models/user_model.dart';
import 'package:ornek/models/user_list_model.dart';
import 'package:ornek/services/delete_user.dart';
import 'package:ornek/services/user_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/manager/manager_user_detail.dart';

// ManagerUserList : kullanıcılarının listelendiği sayfa
class ManagerUserList extends StatefulWidget {
  final int userId;

  const ManagerUserList({super.key, required this.userId});

  @override
  State<ManagerUserList> createState() => _ManagerUserListState();
}

class _ManagerUserListState extends State<ManagerUserList> {
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];

  String searchText = "";
  String roleFilter = "all";
  String statusFilter = "active";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final data = await UserListService.fetchUsers(UserListModel());

    setState(() {
      allUsers = data;
    });

    applyFilters();
  }

  void applyFilters() {
    setState(() {
      filteredUsers = allUsers.where((u) {
        final matchesSearch = u.fullName.toLowerCase().contains(
          searchText.toLowerCase(),
        );

        final matchesRole =
            roleFilter == "all" || u.role.toLowerCase() == roleFilter;

        final matchesStatus =
            statusFilter == "all" || u.status.toLowerCase() == statusFilter;

        return matchesSearch && matchesRole && matchesStatus;
      }).toList();
    });
  }

  void searchUser(String value) {
    searchText = value;
    applyFilters();
  }

  void setRoleFilter(String role) {
    roleFilter = role;
    applyFilters();
  }

  void setStatusFilter(String status) {
    statusFilter = status;
    applyFilters();
  }

  Color getStatusColor(String status) {
    return status.toLowerCase() == "active" ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ManagerUser(userId: widget.userId),
            ),
          );

          fetchData();
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchUser,
              decoration: const InputDecoration(
                hintText: "İsim ara...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: roleFilter,
                  items: const [
                    DropdownMenuItem(value: "all", child: Text("Tümü")),
                    DropdownMenuItem(value: "customer", child: Text("Müşteri")),
                    DropdownMenuItem(value: "bayi", child: Text("Bayi")),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setRoleFilter(val);
                    }
                  },
                ),

                const SizedBox(width: 20),

                DropdownButton<String>(
                  value: statusFilter,
                  items: const [
                    DropdownMenuItem(value: "all", child: Text("Tümü")),
                    DropdownMenuItem(value: "active", child: Text("Aktif")),
                    DropdownMenuItem(value: "passive", child: Text("Pasif")),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setStatusFilter(val);
                    }
                  },
                ),
              ],
            ),
          ),

          // User List
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(child: Text("Kullanıcı bulunamadı"))
                : ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];

                      return Card(
                        child: ListTile(
                          title: Text(user.fullName),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.mail),

                              Text(
                                user.status,
                                style: TextStyle(
                                  color: getStatusColor(user.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(user.role),
                            ],
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Detail
                              IconButton(
                                icon: const Icon(Icons.info),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UserDetail(
                                        user: user,
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Delete
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Kullanıcı Sil"),

                                      content: const Text(
                                        "Bu kullanıcıyı silmek istediğinize emin misiniz?",
                                      ),

                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("İptal"),
                                        ),

                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Sil"),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    try {
                                      final result =
                                          await DeleteUserService.deleteUser(
                                            user.userId,
                                          );

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(result)),
                                      );

                                      fetchData();
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text("Hata oluştu: $e"),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
