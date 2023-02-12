import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<dynamic> getWeatherData() {
    return _provider.getWeatherData();
  }
}

class NetworkError extends Error {}
