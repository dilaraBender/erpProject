import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:ornek/widgets/settings.dart';

// CustomerSettings : müşteri paneli için ayarlar görünümü
class CustomerSettings extends StatefulWidget {
  final int userId;
  final int customerId;
  const CustomerSettings({
    super.key,
    required this.userId,
    required this.customerId,
  });

  @override
  State<CustomerSettings> createState() => _CustomerSettingsState();
}

class _CustomerSettingsState extends State<CustomerSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(userId: widget.userId),
      body: Settings(userId: widget.userId),
    );
  }
}
