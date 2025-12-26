import 'package:dio/dio.dart';
import 'package:hrms/core/network/dio_client.dart';
import 'package:hrms/models/auth_models.dart';
import 'package:hrms/storage/preferences.dart';

class AuthService {
  final Dio _dio = DioClient.dio;

  Future<bool> login(AuthModel data) async {
    try {
      final response = await _dio.post(
        "mobile/login",
        data: data.toJson(),
        options: Options(
          headers: {"Accept": "application/json"},
        ),
      );

      if (response.statusCode == 200 &&
          response.data['status'] == 'success') {

        final userData = response.data['data'];

        await Preferences.saveToken(userData['token']);
        await Preferences.saveUserId(userData['employee_id']);
        await Preferences.saveCompanyId(userData['company_id']);
        await Preferences.saveLocationId(userData['location_id']);
        await Preferences.saveUserName(userData['employee_name']);

        return true;
      }
      return false;

    } on DioException catch (e) {
      print("LOGIN ERROR: ${e.message}");
      return false;
    }
  }
}
