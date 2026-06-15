// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:ornek/manager/manager_customer_details.dart';
import 'package:ornek/models/customer_filter_model.dart';
import 'package:ornek/models/customer_model.dart';
import 'package:ornek/services/customer_list.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/show_message.dart';

//  ManagerCustomerList : müşterilerin listelendiği ve filtrelendiği sayfa
class ManagerCustomerList extends StatefulWidget {
  final int userId;

  const ManagerCustomerList({super.key, required this.userId});

  @override
  State<ManagerCustomerList> createState() => _ManagerCustomerListState();
}

class _ManagerCustomerListState extends State<ManagerCustomerList> {
  List<CustomerModel> customers = [];
  List<CustomerModel> filteredCustomers = [];

  String? selectedStatus;
  String searchText = '';

  final List<String> statuses = ['active', 'passive'];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  Future<void> _fetchCustomers() async {
    try {
      final filters = CustomerFilterModel(status: selectedStatus);

      final fetchedCustomers = await CustomerListService.fetchCustomerList(
        filters,
      );

      setState(() {
        customers = fetchedCustomers;
        _applyFilters();
      });
    } catch (e) {
      showMessage(context, "Veri çekme hatası: $e");
    }
  }

  void _applyFilters() {
    setState(() {
      filteredCustomers = customers.where((customer) {
        final matchesStatus =
            selectedStatus == null ||
            selectedStatus!.isEmpty ||
            customer.status == selectedStatus;

        final matchesSearch =
            searchText.isEmpty ||
            customer.name.toLowerCase().contains(searchText.toLowerCase());

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
    _applyFilters(); // otomatik filtre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Müşteri ara...",
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
              // ignore: deprecated_member_use
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
              onChanged: _onStatusChanged,
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
            child: filteredCustomers.isEmpty
                ? const Center(child: Text("Müşteri bulunamadı"))
                : ListView.builder(
                    itemCount: filteredCustomers.length,
                    itemBuilder: (context, index) {
                      final customer = filteredCustomers[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(customer.name),
                          subtitle: Text(
                            "${customer.email} • ${customer.phone}",
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ManagerCustomerDetails(
                                  userId: widget.userId,
                                  customer: customer,
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
