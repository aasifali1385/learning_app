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
    const base = "http://192.168.1.101:8080/";
    // print(base + file);
    try {
      return await _dio.get(file.replaceAll(' ', ''));
    } on DioException catch (e) {
      return e.response;
    }
  }
  ////////////////////////////////////////////
  Future<dynamic> loadLocal(file) async {
    const base = "http://192.168.1.101:8080/";
    // print(base + file);
    try {
      return await _dio.get(base + file.replaceAll(' ', ''));
    } on DioException catch (e) {
      return e.response;
    }
  }

////////////////////////
}

// Green ff1D384D - ff007442
// Blue ff02318C - ff1A54C6
// Black ff000000 - ff535353
//