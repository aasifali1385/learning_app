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
        baseUrl: 'https://virtualcardhold.web.app/',
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

    try {
      return await _dio.get('$file.json'.replaceAll(" ", ''));
    } on DioException catch (e) {
      return e.response;
    }
  }

////////////////////////
}
