// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:ornek/models/user_model.dart';
import 'package:ornek/widgets/app_bar.dart';

// UserDetail : kullanıcı detaylarının gösterildiği sayfa
class UserDetail extends StatefulWidget {
  final int userId;
  final UserModel user;

  const UserDetail({super.key, required this.userId, required this.user});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBarWidget(userId: widget.userId),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ÜST PROFİL KARTI
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xff0F766E), Color(0xff115E59)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xff0F766E),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      widget.user.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.user.role,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // DETAY KARTI
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Kullanıcı Bilgileri",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),

                      const SizedBox(height: 20),

                      detailRow(
                        Icons.person_outline,
                        "Ad Soyad",
                        widget.user.fullName,
                      ),

                      const SizedBox(height: 16),

                      detailRow(Icons.email_outlined, "Mail", widget.user.mail),

                      const SizedBox(height: 16),

                      if (widget.user.bayiPhone != null)
                        detailRow(
                          Icons.phone_outlined,
                          "Telefon",
                          widget.user.bayiPhone!,
                        ),

                      if (widget.user.customerPhone != null)
                        detailRow(
                          Icons.phone_outlined,
                          "Telefon",
                          widget.user.customerPhone!,
                        ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.calendar_month_outlined,
                        "Kayıt Tarihi",
                        "${widget.user.registerDate}",
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.info_outline,
                        "Durum",
                        widget.user.status,
                        valueColor: widget.user.status.toLowerCase() == "active"
                            ? Colors.green
                            : Colors.red,
                      ),

                      const SizedBox(height: 16),

                      detailRow(
                        Icons.admin_panel_settings_outlined,
                        "Rol",
                        widget.user.role,
                      ),
                    ],
                  ),
                ),
              ),

              // BAYİLİK BİLGİLERİ
              if (widget.user.bayiTitle != null) ...[
                const SizedBox(height: 20),

                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Bayilik Bilgileri",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),

                        const SizedBox(height: 20),

                        detailRow(
                          Icons.badge_outlined,
                          "Vergi Numarası",
                          widget.user.bayiTaxNo ?? "-",
                        ),

                        const SizedBox(height: 16),

                        detailRow(
                          Icons.business_outlined,
                          "Şirket Adı",
                          widget.user.bayiTitle ?? "-",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(
    IconData icon,
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffECFDF5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xff0F766E)),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
