class AppUrl {
  static const bool isLive = false;

  static const String prodUrl = "https://eye2api.e-qualitygroup.com";
  static const String stageUrl =
      "https://eye2dev1-stagingapi.azurewebsites.net";

  static String get baseUrl => isLive ? prodUrl : stageUrl;

  static String get login => "$baseUrl/api/Login/Get";
  static String get channelData => "$baseUrl/api/TT/GetChannelsDataV2";
  static String get uploadMession => "$baseUrl/api/TT/UploadData";
}
