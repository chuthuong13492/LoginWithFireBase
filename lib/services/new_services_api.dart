import 'package:dio/dio.dart';

class HttpService {
  // final baseUrl = "https://reqres.in/";
  static BaseOptions options = new BaseOptions(
      // baseUrl: 'https://localhost:5001/api/',
      baseUrl: 'https://reqres.in/',
      headers: {
        Headers.contentTypeHeader: "application/json",
      },
      sendTimeout: 15000,
      receiveTimeout: 5000);
  Dio _dio;
  HttpService() {
    _dio = new Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handler) {
        print("${request.method} ${request.baseUrl}${request.path}");
        return handler.next(request);
      },
      onResponse: (response, handler) {
        print("${response.data}");
        return handler.next(response);
      },
      onError: (error, handler) {
        print("${error.message}");
        return handler.next(error);
      },
    ));
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
}
