const String newsApiBaseUrl = "https://newsapi.org/v2";
const String produtApiBaseUrl = "https://dummyjson.com";

const String newsAPIKey = "dcb85bb7994546748ce854b82bbd6af7";
const String country = "us";
const String category = "general";
const String kDefaultImage =
    "https://www.google.com/search?q=default+image&client=firefox-b-d&sxsrf=APq-WBskmtr-ix6NUAqqiHFNpsJX6JSOTg:1650026644151&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjEi_qfjJb3AhXvQd8KHd02BKUQ_AUoAXoECAEQAw#imgrc=A0pMe2lq2NT_jM";

class Urls {
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'cc95d932d5a45d33a9527d5019475f2c';
  static String currentWeatherByName(String city) =>
      '$weatherBaseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'https://openweathermap.org/img/wn/$iconCode@2x.png';
}
