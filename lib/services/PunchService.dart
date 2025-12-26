import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hrms/core/network/dio_client.dart';
import 'package:hrms/storage/preferences.dart';
import 'package:intl/intl.dart'; // <- import intl

class PunchService {
  final Dio _dio = DioClient.dio;

  Future<void> sendPunch({
    required String userId,
    required int companyId,
    required int locationId,
    required String latitude,
    required String longitude,
  }) async {
    final token = await Preferences.getToken();

    // Format date as "yyyy-MM-dd HH:mm:ss"
    final punchTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final data = [{
      "user_id": userId,
      "company_id": companyId,
      "location_id": locationId,
      "punch_time": punchTime,
      "latitude": latitude,
      "longitude": longitude,
    }];
debugPrint("Punch Error8***************: $data");
    final response = await _dio.post(
      "mobile/attendance/upload",
      data: data,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    print("PUNCH RESPONSE: ${response.data}");
  }
}
