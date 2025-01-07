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
    // const base = "http://192.168.88.22:8080/";
    const base = "http://192.168.1.102:8080/";

    print(base + file);
    try {
      return await _dio.get(base + file.replaceAll(' ', ''));
    } on DioException catch (e) {
      return e.response;
    }
  }

////////////////////////
}
