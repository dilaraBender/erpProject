import 'package:flutter/material.dart';
import 'package:ornek/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// Info : Müşteri panelinde şirket bilgilendirimesi için kullanılan sayfa
class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),

      // kaydırma cubuğu için
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset('resimler/drone.webp', width: 80)),

              const SizedBox(height: 24),

              _infoCard(
                title: 'Biz Kimiz?',
                content:
                    'Pata Technology, Türkiye’de drone ile dış cephe temizliğini '
                    'profesyonel şekilde uygulayan ilk firma olma özelliğini taşımaktadır.',
              ),

              _infoCard(
                title: 'Neden Pata Technology?',
                content:
                    'Geleneksel temizlik yöntemleri zaman alıcı, riskli ve maliyetlidir. '
                    'Biz bu süreci daha hızlı, daha güvenli ve daha ekonomik hale getiriyoruz.',
                bullets: const ['Daha Hızlı', 'Daha Güvenli', 'Daha Ekonomik'],
              ),

              _infoCard(
                title: 'Nasıl Çalışıyoruz?',
                content:
                    'Son teknolojiye sahip temizlik dronelarımız ve alanında uzman ekibimizle '
                    'maksimum güvenlikli bir çalışma ortamı sağlıyoruz.',
                bullets: const [
                  'İz bırakmaz',
                  'Çizik oluşturmaz',
                  'Yüzeyleri uzun süre temiz tutar',
                ],
              ),

              _infoCard(
                title: 'Farkımız',
                content:
                    'Pata Technology, drone teknolojisini dış cephe temizlik sistemine '
                    'entegre eden ilk Türk şirketidir.',
                bullets: const [
                  'Zaman kaybı minimum',
                  'İş güvenliği maksimum',
                  'Maliyet avantajı büyük',
                ],
              ),

              _infoCard(
                title: 'Vizyonumuz',
                content:
                    'Geleneksel ve riskli temizlik yöntemlerinin yerini, '
                    'daha güvenli, daha hızlı ve daha etkili çözümlerle değiştirmeyi amaçlıyoruz.',
              ),

              TextButton.icon(
                onPressed: _openWeb,
                icon: const Icon(Icons.language),
                label: const Text(
                  'www.patatechnology.com',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// kod tekrarını önlemek için kartlarımızın ortak özelliklerini widget ile fonk. şeklinde toparladık
Widget _infoCard({
  //parametrelerimiz
  required String title,
  required String content,
  List<String>? bullets,
}) {
  return Card(
    // gölgelendirme
    elevation: 4,
    // boşluk
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(
      // kenar yuvarlatma
      borderRadius: BorderRadius.circular(12),
    ),

    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text(content, style: const TextStyle(fontSize: 16)),

          //... birden fazla nesne ekleyecegimizi söylüyor sizedbox,padding vs.
          if (bullets != null) ...[
            const SizedBox(height: 12),

            // neden map kullanıyoruz? amacımız elimizdeki listeyi widget cinsine dönüştürmek bu dönüştürmelerde kullanılır
            ...bullets.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                // listelenecek elemanların her biri text olarak yazılıyor
                child: Text('• $b', style: const TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

//Future<void> bu fonk. biraz uzun süreceğini söylüyor yani bi işlem yapıyorum bekletebilirim(bizim işlemimiz tarayıcıya bağlanmak)
//async bu fonk. içinde AWAIT kullanacagım diyor await işlem tamamlanana kadar bekleyerek flutterın donmasını engeller
Future<void> _openWeb() async {
  // baglanacagımız sayfanın adresini değişkene atadık
  final Uri url = Uri.parse('https://patatechnology.com/');

  // launchUrl ile ilgili adresi varsayılan tarayıcıdan açıyoruz açılmazsa throw ile hata fırlatıyoruz
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Başarısız';
  }
}
