import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:spenn/src/models/models.dart';
import 'package:spenn/src/spenn_errors.dart';

/// {@template spenn}
/// An object to communicate with the SPENN Business Partner API.
/// {@endtemplate}
class Spenn {
  /// {@macro spenn}
  Spenn({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  /// An http Client object to handle http requests
  final http.Client _httpClient;

  /// API authority.
  ///
  /// exposed for testing purposes.
  @visibleForTesting
  static const authority = 'uat-idsrv.spenn.com';

  /// Autenticate a Business Partner account.
  /// Returns an instance of [SpennSession]
  Future<SpennSession> authenticate({
    String grantType = 'api_key',
    required String apiKey,
    required String clientId,
    required String clientSecret,
    required String audience,
  }) async {
    final uri = Uri.https(authority, '/token');
    final body = <String, String>{
      'grant_type': grantType,
      'api_key': apiKey,
      'client_id': clientId,
      'client_secret': clientSecret,
      'audience': audience,
    };

    http.Response res;
    try {
      res = await _httpClient.post(
        uri,
        body: body,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        encoding: Encoding.getByName('utf-8'),
      );
    } catch (_) {
      throw SpennHttpException();
    }

    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode);
    }

    Map data;
    try {
      data = json.decode(res.body) as Map;
    } catch (_) {
      throw SpennJsonDecodeException();
    }

    try {
      return SpennSession.fromMap(data as Map<String, dynamic>);
    } catch (_) {
      throw SpennJsonDeserializationException();
    }
  }

  /// Sends a payment request to a user from a Business Partner.
  /// Returns an instance of [PaymentRequest].
  Future<PaymentRequest> createRequest({
    required String phoneNumber,
    required double amount,
    required String message,
    required String externalReference,
    required String apiKey,
  }) async {
    final uri = Uri.https(authority, '/api/Partner/transaction/request');
    final payload = <String, dynamic>{
      'phoneNumber': phoneNumber,
      'amount': amount,
      'message': message,
      'externalReference': externalReference,
    };
    http.Response res;

    try {
      res = await http.post(uri, body: payload, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      });
    } catch (_) {
      throw SpennHttpException();
    }
    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode);
    }

    Map data;
    try {
      data = json.decode(res.body) as Map;
    } catch (_) {
      throw SpennJsonDecodeException();
    }

    try {
      return PaymentRequest.fromMap(data as Map<String, dynamic>);
    } catch (_) {
      throw SpennJsonDeserializationException();
    }
  }
}
