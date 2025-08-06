import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/models/upload/mission_upload_model.dart';
import 'package:flutter_salesman_module/utils/constants/app_url.dart';
import 'package:http/http.dart' as http;

class UploadApi {
  static Future<MissionUploadDetails> uploadMissionApi(
    String username,
    String userid,
    String date,
    String token,
    MissionUploadDetails missionModel,
  ) async {
    try {
      String uploadUrl = "${AppUrl.uploadMession}?userid=$userid";
      print("Using URL: $uploadUrl");

      final headers = {
        'Content-Type': 'application/json',
        'username': username,
        'token': token,
        'date': date,
      };

      final body = jsonEncode(missionModel.toJson());

      print("sssssssssssss$body");

      final response = await http
          .put(Uri.parse(uploadUrl), headers: headers, body: body)
          .timeout(const Duration(minutes: 2));

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      void logJsonPart(String label, List<dynamic>? items) {
        if (items == null) {
          debugPrint('⚠️ $label is null');
          return;
        }
        try {
          final jsonList = items.map((e) => e.toJson()).toList();
          final encoded = jsonEncode(jsonList);
          debugPrint('✅ $label JSON: $encoded');
        } catch (e, stack) {
          debugPrint('❌ Failed to encode $label: $e');
          debugPrint('🔍 Stack: $stack');
        }
      }

      logJsonPart("Product", missionModel.product);
      logJsonPart("Price", missionModel.price);
      logJsonPart("Place", missionModel.place);
      logJsonPart("Promo", missionModel.promo);

      if (response.statusCode == 200) {
        if (response.body.trim().isEmpty) {
          print("Upload successful, but response body is empty.");
          return missionModel;
        } else {
          final data = MissionUploadDetails.fromJson(
            json.decode(response.body),
          );
          return data;
        }
      } else {
        throw Exception(
          "Failed to upload: ${response.statusCode} ${response.body}",
        );
      }
    } catch (error) {
      print("Upload Error: $error");
      rethrow;  
    }
  }
}
