import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:spenn/src/models/models.dart';
import 'package:spenn/src/spenn_errors.dart';

/// {@template spenn}
/// An object to communicate with the SPENN Business Partner API.
/// {@endtemplate}
class Spenn {
  /// {@macro spenn}
  Spenn({Dio? dio}) : _dio = dio ?? Dio();

  /// An http Client object to handle http requests
  final Dio _dio;

  /// API url authority.
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

    Response<Map<String, dynamic>> res;
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    try {
      res = await _dio.postUri<Map<String, dynamic>>(uri, data: body);
    } catch (_) {
      throw SpennHttpException();
    }

    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode);
    }

    if (res.data == null || res.data!.isEmpty) {
      throw SpennTypeError();
    }

    try {
      return SpennSession.fromMap(res.data!);
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
    required String token,
  }) async {
    final uri = Uri.https(authority, '/api/Partner/transaction/request');
    final payload = <String, dynamic>{
      'phoneNumber': phoneNumber,
      'amount': amount,
      'message': message,
      'externalReference': externalReference,
    };
    Response<Map<String, dynamic>> res;

    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      res = await _dio.postUri(uri, data: payload);
    } catch (_) {
      throw SpennHttpException();
    }
    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode, body: res.data);
    }

    if (res.data == null || res.data!.isEmpty) {
      throw SpennTypeError();
    }

    try {
      return PaymentRequest.fromMap(res.data!);
    } catch (_) {
      throw SpennJsonDeserializationException();
    }
  }

  /// Cancel a payment request
  Future<PaymentRequest> cancelRequest({
    required String requestGuid,
    required String token,
  }) async {
    final uri = Uri.https(authority, '/api/Partner/transaction/request/cancel');
    final payload = <String, String>{'requestMoneyGuid': requestGuid};

    Response<Map<String, dynamic>> res;

    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      res = await _dio.postUri(uri, data: payload);
    } catch (_) {
      throw SpennHttpException();
    }
    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode, body: res.data);
    }

    if (res.data == null || res.data!.isEmpty) {
      throw SpennTypeError();
    }

    try {
      return PaymentRequest.fromMap(res.data!);
    } catch (_, s) {
      throw SpennJsonDeserializationException();
    }
  }

  /// Check the status of the payment request at the specified [requestGuid]
  /// Returns a new [DetailedPaymentRequest] object.
  Future<DetailedPaymentRequest> checkRequestStatus({
    required String requestGuid,
    required String token,
  }) async {
    final uri =
        Uri.https(authority, '/api/Partner/transaction/request/$requestGuid');
    Response<Map<String, dynamic>> res;
    final payload = <String, String>{'requestMoneyGuid': requestGuid};
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.method = 'GET';
      res = await _dio.requestUri(uri, data: payload);
    } catch (_) {
      throw SpennHttpException();
    }

    if (res.statusCode != 200) {
      throw SpennHttpRequestFailure(statusCode: res.statusCode, body: res.data);
    }

    if (res.data == null || res.data!.isEmpty) {
      throw SpennTypeError();
    }

    try {
      return DetailedPaymentRequest.fromMap(res.data!);
    } catch (_) {
      throw SpennJsonDeserializationException();
    }
  }
}
