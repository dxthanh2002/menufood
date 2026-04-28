import 'dart:io';

class Configuration {
  // static String appidStr = Platform.isIOS ? 'h69e5addb0b438' : 'h69e0f1cbe41bf';

  // static String appidkeyStr = Platform.isIOS
  //     ? 'ae69c40ea7a710759685bc53b15c796e8'
  //     : 'ad688a334ae7556a1d8ed624f768c7fc9';

  // // we are using
  // static String autoRewarderPlacementID = Platform.isIOS
  //     ? 'n69e5aed45253b'
  //     : 'n69e0f4102e66a';

  // static String interstitial = Platform.isIOS
  //     ? 'n69e5adf75ba4c'
  //     : 'n69e0f2046d569';

  // not use
  static String appidStr = 'h69c34ae64bc55';
  static String appidkeyStr = 'a3444276b691cc43de2178f797f33389c';

  static String autoRewarderPlacementID = 'n69c34b203beef';
  static String rewarderTest = 'n69c34b203beef';
  static String interstitial = 'n69c34b1fb07c2';

  static String rewarderPlacementID = Platform.isIOS
      ? 'n69c34b203beef'
      : 'n69e0f4102e66a';

  static String interstitialPlacementID = Platform.isIOS
      ? 'n69c34b1fb07c2'
      : 'n69e0f2046d569';

  static String bannerPlacementID = Platform.isIOS
      ? 'n69c34b1f0cd5d'
      : 'n696f32fd168a9';

  static String nativePlacementID = Platform.isIOS
      ? 'n69c34b20bd978'
      : 'n696e4147dcd7f';

  static String splashPlacementID = Platform.isIOS
      ? 'b5c22f0e5cc7a0'
      : 'b62b0272f8762f';

  static String rewardedShowCustomExt = 'RewardedShowCustomExt';
  static String interstitialShowCustomExt = 'InterstitialShowCustomExt';
  static String splashShowCustomExt = 'SplashShowCustomExt';
  static String bannerShowCustomExt = 'BannerShowCustomExt';
  static String nativeShowCustomExt = 'NativeShowCustomExt';

  static String rewarderSceneID = Platform.isIOS
      ? 'f5e54970dc84e6'
      : 'n69e0f4102e66a';

  static String autoRewarderSceneID = Platform.isIOS
      ? 'f5e54970dc84e6'
      : 'n69e0f4102e66a';

  static String interstitialSceneID = Platform.isIOS
      ? 'f5e549727efc49'
      : 'n69e0f2046d569';

  static String autoInterstitialSceneID = Platform.isIOS
      ? 'f5e549727efc49'
      : 'n69e0f2046d569';

  static String nativeSceneID = Platform.isIOS
      ? 'f600938967feb5'
      : 'f600e5f8b80c14';

  static String bannerSceneID = Platform.isIOS
      ? 'f600938d045dd3'
      : 'f600e6039e152c';

  static String splashSceneID = Platform.isIOS
      ? 'f5e549727efc49'
      : 'f628c7999265cd';

  static String debugKey = Platform.isIOS
      ? '99117a5bf26ca7a1923b3fed8e5371d3ab68c25c'
      : 'aa3d1b3dffe65c68551105fd1abd666781bbc3e6';
}
