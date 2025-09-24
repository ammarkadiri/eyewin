import 'dart:convert';
import 'package:flutter_salesman_module/models/upload/mission_server_upload.dart';
import 'package:flutter_salesman_module/utils/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class UploadApi {
  static Future<MissionUploadServerModel> uploadMissionApi(
    String username,
    String userid,
    String date,
    String token,
    MissionUploadServerModel mission,
  ) async {
    try {
      String uploadUrl = "${AppUrl.uploadMession}?userid=$userid";

      final headers = {
        'Content-Type': 'application/json',
        'username': username,
        'token': token,
        'date': date,
      };

      final body = jsonEncode(mission.toJson());
      developer.log(jsonEncode(mission.toJson()), name: 'MISSION_JSON');
      final response = await http
          .put(Uri.parse(uploadUrl), headers: headers, body: body)
          .timeout(const Duration(minutes: 2));

      if (response.statusCode == 200) {
        if (response.body.trim().isEmpty) {
          return mission;
        } else {
          return MissionUploadServerModel.fromJson(json.decode(response.body));
        }
      } else {
        throw Exception(
          "Failed to upload: ${response.statusCode} ${response.body}",
        );
      }
    } catch (error) {
      rethrow;
    }
  }
}
