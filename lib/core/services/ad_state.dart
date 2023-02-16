import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState extends ChangeNotifier {
  AdState();

  late Future<InitializationStatus> initialization;

  init() {
    initialization = MobileAds.instance.initialize();
  }

  String get bannerId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6651367008928070/5744793533';
    } else {
      return '';
    }
  }

  AdManagerBannerAdListener get adListener => _adListener;

  final AdManagerBannerAdListener _adListener = AdManagerBannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print("Ad failed to load: $error");
    },
    onAdOpened: (Ad ad) => print("Ad opened"),
    onAdClosed: (Ad ad) => print("Ad closed"),
  );
}
