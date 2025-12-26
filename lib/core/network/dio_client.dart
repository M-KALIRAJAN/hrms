import 'package:dio/dio.dart';
import 'package:hrms/storage/preferences.dart';


class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://hrms.cnxhub.in/public/api/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );
}
