import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:linos_dictionary/config.dart';
import 'package:linos_dictionary/words.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static BannerAd _bannerAd;
  static const String APP_NAME = "Lino's Dictionary";
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices:
        Config.TEST_DEVICE != null ? <String>[Config.TEST_DEVICE] : null,
  );

  static getBannerAd() {
    if (_bannerAd != null) {
      return _bannerAd;
    }

    _bannerAd = BannerAd(
        adUnitId: Config.isReleaseMode()
            ? Config.getAdUnitId()
            : BannerAd.testAdUnitId,
        size: AdSize.fullBanner);

    return _bannerAd;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(
        appId: Config.isReleaseMode()
            ? Config.getAppAdId()
            : FirebaseAdMob.testAppId);

    MyApp.getBannerAd()
    ..load()
    ..show(
      anchorOffset: 0.0,
      horizontalCenterOffset: 0.0,
      anchorType: AnchorType.bottom,
    );

    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordsPage(),
    );
  }
}
