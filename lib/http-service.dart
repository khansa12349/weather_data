// this file is for requesting http service using dio
import 'package:dio/dio.dart';

class HttpService {
   late Dio _dio;
  static String apikey = "2dba79d2ea3efcd5c47300a3c61edfaa";
  final baseUrl="https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}";


  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

   // initializeInterceptors();
  }


  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }


  // initializeInterceptors() {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //       onError: (error, errorInterceptorHandler) {
  //         print(error.message);
  //       },
  //       onRequest: (request, requestInterceptorHandle) {
  //         print("${request.method} ${request.path}");
  //       },
  //       onResponse: (response, responseInterceptorHandle) {
  //         print(response.data);
  //       }
  //   )
  //   );
 // }
}

