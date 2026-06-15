// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_bayi_details.dart';
import 'package:ornek/models/bayi_filter_model.dart';
import 'package:ornek/models/bayi_model.dart';
import 'package:ornek/services/bayi_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';

// ManagerBayiList : bayilerin listelendiği sayfa
class ManagerBayiList extends StatefulWidget {
  final int userId;

  const ManagerBayiList({super.key, required this.userId});

  @override
  State<ManagerBayiList> createState() => _ManagerBayiListState();
}

class _ManagerBayiListState extends State<ManagerBayiList> {
  List<BayiModel> bayis = [];
  List<BayiModel> filteredBayis = [];

  String? selectedStatus;
  String searchText = '';

  final List<String> statuses = ['active', 'passive'];

  @override
  void initState() {
    super.initState();
    _fetchBayis();
  }

  Future<void> _fetchBayis() async {
    try {
      final filters = BayiFilter(status: selectedStatus);

      final fetchedBayis = await BayiListService.fetchBayiList(filters);

      setState(() {
        bayis = fetchedBayis;
        _applyFilters();
      });
    } catch (e) {
      showMessage(context, "Veri çekme hatası: $e");
    }
  }

  void _applyFilters() {
    setState(() {
      filteredBayis = bayis.where((bayi) {
        final matchesStatus =
            selectedStatus == null ||
            selectedStatus!.isEmpty ||
            bayi.status == selectedStatus;

        final matchesSearch =
            searchText.isEmpty ||
            bayi.name.toLowerCase().contains(searchText.toLowerCase());

        return matchesStatus && matchesSearch;
      }).toList();
    });
  }

  void _onSearchChanged(String value) {
    searchText = value;
    _applyFilters();
  }

  void _onStatusChanged(String? value) {
    selectedStatus = value;
    _applyFilters(); // 👈 otomatik filtre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: Column(
        children: [
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Bayi ara...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String?>(
              value: selectedStatus,
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text("Tüm Durumlar"),
                ),
                ...statuses.map(
                  (s) => DropdownMenuItem(value: s, child: Text(s)),
                ),
              ],
              onChanged: _onStatusChanged, // 👈 anında filtre
              decoration: InputDecoration(
                labelText: "Durum",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: filteredBayis.isEmpty
                ? const Center(child: Text("Bayi bulunamadı"))
                : ListView.builder(
                    itemCount: filteredBayis.length,
                    itemBuilder: (context, index) {
                      final bayi = filteredBayis[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(bayi.title),
                          subtitle: Text("${bayi.mail} • ${bayi.city ?? ''}"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ManagerBayiDetails(
                                  userId: widget.userId,
                                  bayi: bayi,
                                ),
                              ),
                            );
                          },
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
