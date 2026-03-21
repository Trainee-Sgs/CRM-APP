import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/SignIn/splash.dart';
import '../Services/preference_service.dart';

class LoginApi {
  static const String baseUrl = 'https://erpsmart.in/total/api/m_api/';

  /// Handles user sign-in by requesting an OTP.
  /// [inputValue] can be mobile, whatsapp, or email.
  /// [method] can be 'mobile', 'whatsapp', 'mail', or 'sms'.
  static Future<Map<String, dynamic>> signIn({
    required String inputValue,
    required String method,
  }) async {
    String deviceId = SplashScreen.deviceId ?? '123456';
    String ln = SplashScreen.ln ?? '123';
    String lt = SplashScreen.lt ?? '123';
    String currentCid = await PreferenceService.getCid();

    Map<String, String> body = {
      'cid': currentCid,
      'type': '3001',
      'device_id': deviceId,
      'ln': ln,
      'lt': lt,
    };

    if (method == 'mail') {
      body['email'] = inputValue;
    } else if (method == 'whatsapp') {
      body['wp_number'] = inputValue;
      body['mobile'] = inputValue;
    } else {
      body['mobile'] = inputValue;
    }

    final response = await http.post(Uri.parse(baseUrl), body: body);
    return json.decode(response.body);
  }

  /// Verifies the OTP provided by the user.
  static Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required String mobile,
  }) async {
    String deviceId = SplashScreen.deviceId ?? '123456';
    String ln = SplashScreen.ln ?? '123';
    String lt = SplashScreen.lt ?? '123';
    String currentCid = await PreferenceService.getCid();

    Map<String, String> body = {
      'type': '3002',
      'cid': currentCid,
      'otp': otp,
      'mobile': mobile,
      'device_id': deviceId,
      'ln': ln,
      'lt': lt,
    };

    final response = await http.post(Uri.parse(baseUrl), body: body);
    return json.decode(response.body);
  }

  /// Handles user registration.
  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String phone,
    required String whatsapp,
  }) async {
    String deviceId = SplashScreen.deviceId ?? '123456';
    String ln = SplashScreen.ln ?? '123';
    String lt = SplashScreen.lt ?? '123';
    String currentCid = await PreferenceService.getCid();

    Map<String, String> body = {
      'name': name,
      'number': phone,
      'wp_number': whatsapp,
      'email': email,
      'cid': currentCid,
      'type': '3000',
      'device_id': deviceId,
      'ln': ln,
      'lt': lt,
    };

    final response = await http.post(Uri.parse(baseUrl), body: body);
    return json.decode(response.body);
  }
}
