class Urls {
  static const String weatherAPIScheme = "https";
  static const String weatherAPIHost = "api.openweathermap.org";
  static const String weatherAPIPath = "/data/2.5/weather";
  static const String apiKey = "53b485e9e970ee79b2a3ef3bbc3c42b3";

  static const String iconAPIScheme = "http";
  static const String iconAPIHost = "openweathermap.org";
  static const String iconAPIPath = "/img/wn/{{iconCode}}@2x.png";

  static String currentWeatherByName(String city) {
    var uri = Uri(
      scheme: weatherAPIScheme,
      host: weatherAPIHost,
      path: weatherAPIPath,
      queryParameters: {
        "q": city,
        "appid": apiKey,
      },
    );

    return uri.toString();
  }

  static String weatherIcon(String iconCode) {
    var uri = Uri(
      scheme: iconAPIScheme,
      host: iconAPIHost,
      path: iconAPIPath.replaceAll("{{iconCode}}", iconCode),
    );

    return uri.toString();
  }
}
