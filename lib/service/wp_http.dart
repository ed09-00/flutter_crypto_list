import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;
  //your url
  final baseUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  // final String apiKey =  'bce125e3-c148-45ef-84cc-5724bb11da39';
  // final String apiValue = 'X-CMC_PRO_API_KEY'

  HttpService({String? apiKey,String? apiValue}) {
    _dio = Dio(BaseOptions(
      
    ));
    if (apiKey!=null) {
      _dio.options.headers[apiValue??""] = apiKey;
    }

    initializeInterceptors();
    
  }
  Future<Response> _request(String path, {required String method}) async {
    Response response;
    try {
      response = await _dio.request(path, options: Options(method: method));
    } on DioException catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> get(String path) async {
    return _request(path, method: 'get');
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("${options.method} ${options.path}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}