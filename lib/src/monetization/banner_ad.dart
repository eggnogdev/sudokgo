import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SudokGoBannerAd extends StatefulWidget {
  const SudokGoBannerAd({super.key});

  @override
  State<SudokGoBannerAd> createState() => _SudokGoBannerAdState();
}

class _SudokGoBannerAdState extends State<SudokGoBannerAd> {
  late BannerAd banner;
  bool loading = true;

  final String testUnitId = 'ca-app-pub-3940256099942544/6300978111';
  final String unitId = 'ca-app-pub-3245400651004869/5569370967';
  
  @override
  void initState() {
    super.initState();
    
    banner = BannerAd(
      adUnitId: testUnitId,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );

    banner.load().then(
      (value) {
        setState(() {
          loading = false;
        });  
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return loading ?
      const SizedBox() :
      SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner),
      );
  }
}
