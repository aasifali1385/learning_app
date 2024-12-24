import 'package:dio/dio.dart';

class Api {
  static final Api _instance = Api._internal();

  factory Api() => _instance;
  late Dio _dio;

  Api._internal() {
    _initDio();
  }

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://universe-25a9c.web.app/',
        // headers: {
        //   "Authorization": "Bearer 123456789abcdef",
        //   "Content-Type": "application/json"
        // },
      ),
    );
  }

  Dio get dio => _dio;

  ////////////////////////////////////////////
  Future<dynamic> load(file) async {
    print(file);
    try {
      // return await _dio.get("http://192.168.137.1:8080/$file");
      return await _dio.get("http://192.168.1.101:8080/$file");
    } on DioException catch (e) {
      return e.response;
    }
  }

////////////////////////
}
