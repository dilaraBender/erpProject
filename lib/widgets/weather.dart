import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// WeeklyWeatherWidget : Hava durumunu gösteren sayfa
class WeeklyWeatherWidget extends StatefulWidget {
  final double lat;
  final double lon;

  const WeeklyWeatherWidget({super.key, required this.lat, required this.lon});

  @override
  State<WeeklyWeatherWidget> createState() => _WeeklyWeatherWidgetState();
}

class _WeeklyWeatherWidgetState extends State<WeeklyWeatherWidget> {
  final String apiKey = "9d35bf1aff43152ef72f9539cf2b68be";

  late Future<List<Map<String, dynamic>>> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = fetchWeather(widget.lat, widget.lon);
  }

  Future<List<Map<String, dynamic>>> fetchWeather(
    double lat,
    double lon,
  ) async {
    final weatherUrl = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast"
      "?lat=$lat&lon=$lon"
      "&appid=$apiKey"
      "&units=metric"
      "&lang=tr",
    );

    final response = await http.get(weatherUrl);

    if (response.statusCode != 200) {
      throw Exception("API Hatası: ${response.statusCode}");
    }

    final data = json.decode(response.body);

    return groupByDay(data["list"]);
  }

  List<Map<String, dynamic>> groupByDay(List list) {
    Map<String, Map<String, dynamic>> daily = {};

    for (var item in list) {
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(item["dt"] * 1000);

      String key = "${dt.year}-${dt.month}-${dt.day}";

      if (!daily.containsKey(key)) {
        daily[key] = item;
      } else {
        DateTime existing = DateTime.fromMillisecondsSinceEpoch(
          daily[key]!["dt"] * 1000,
        );

        if ((dt.hour - 12).abs() < (existing.hour - 12).abs()) {
          daily[key] = item;
        }
      }
    }

    return daily.values.toList();
  }

  String getDayName(DateTime date) {
    const days = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Paz"];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: weatherFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: 180,
            child: Center(
              child: Text(
                "Hata: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        final list = snapshot.data ?? [];

        if (list.isEmpty) {
          return const SizedBox(
            height: 180,
            child: Center(child: Text("Veri yok")),
          );
        }

        return SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              final temp = item["main"]["temp"];
              final icon = item["weather"][0]["icon"];

              final dt = DateTime.fromMillisecondsSinceEpoch(item["dt"] * 1000);

              return Container(
                width: 120,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade200],
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getDayName(dt),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Image.network(
                      "https://openweathermap.org/img/wn/$icon@2x.png",
                      width: 45,
                      height: 45,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "${temp.round()}°C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      item["weather"][0]["description"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
