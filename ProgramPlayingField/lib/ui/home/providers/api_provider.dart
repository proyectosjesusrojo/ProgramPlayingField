import 'package:dio/dio.dart';
import 'package:programplayingfield/ui/home/models/get_weather_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      "http://api.weatherstack.com/current?access_key=6fb264a120bc1a5e3fa60a7a00de35fd&query=Caracas";

  Future<dynamic> getWeatherData() async {
    try {
      dynamic response = await _dio.post(_url);
      return GetWeatherModel.fromJson(response.data);
    } on DioError catch (e) {
      return "error";
    }
    //return "error";
  }
}
