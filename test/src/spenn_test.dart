import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spenn/spenn.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockDio extends Mock implements Dio {
  MockDio([BaseOptions? options]) : _options = options ?? BaseOptions();
  final BaseOptions _options;
  @override
  BaseOptions get options => _options;
}

void main() {
  late Dio dio;
  late Spenn spenn;

  group('Spenn', () {
    setUp(() {
      dio = MockDio();
      spenn = Spenn(dio: dio);
    });

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    test('constructor returns normally', () {
      expect(() => Spenn(), returnsNormally);
    });

    group('authenticate', () {
      const apiKey = 'api-key-test';
      const clientId = '1234';
      const clientSecret = 'secret';
      const audience = 'audience-test';
      const path = '/token';
      final uri = Uri.https(Spenn.authority, path);
      final options = RequestOptions(path: path, baseUrl: Spenn.authority);
      final response = <String, dynamic>{
        'access_token': 'token',
        'token_type': 'bearer',
        'expires_in': 12000,
        'type': 'User',
        'clientId': clientId,
        'audience': audience,
        'refresh_token': 'refresh-token',
        '.issued': '2021-08-31',
        '.expires': '2021-09-01'
      };

      setUp(() {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            requestOptions: options,
            data: response,
            statusCode: 200,
          ),
        );
      });

      test('calls dio.postUri', () async {
        await spenn.authenticate(
          apiKey: apiKey,
          clientId: clientId,
          clientSecret: clientSecret,
          audience: audience,
        );

        verify(() => dio.postUri<Map<String, dynamic>>(uri,
            data: any(named: 'data'))).called(1);
      });

      test('throws a SpennHttpException when http request fails', () {
        when(() => dio.postUri(any(), data: any(named: 'data')))
            .thenThrow(Exception());
        expect(
          () => spenn.authenticate(
              apiKey: apiKey,
              clientId: clientId,
              clientSecret: clientSecret,
              audience: audience),
          throwsA(isA<SpennHttpException>()),
        );
      });

      test('throws a SpennHttpRequestFailure when the status code is not 200',
          () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: {},
            statusCode: 401,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
          () => spenn.authenticate(
            apiKey: apiKey,
            clientId: clientId,
            clientSecret: clientSecret,
            audience: audience,
          ),
          throwsA(isA<SpennHttpRequestFailure>()),
        );
      });

      test('throws a SpennTypeError when the response body is null', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: null,
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );

        expect(
            () => spenn.authenticate(
                  apiKey: apiKey,
                  clientId: clientId,
                  clientSecret: clientSecret,
                  audience: audience,
                ),
            throwsA(isA<SpennTypeError>()));
      });

      test(
          'throws a SpennJsonDeserializationException when the response body '
          'has a non-supported pattern and fails to deserialize', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: {'not-a-token': 'i am a token'},
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
            () => spenn.authenticate(
                apiKey: apiKey,
                clientId: clientId,
                clientSecret: clientSecret,
                audience: audience),
            throwsA(isA<SpennJsonDeserializationException>()));
      });
    });

    group('createRequest', () {
      const phoneNumber = '0700000000';
      const amount = 125.99;
      const message = 'just for testing';
      const externalReference = 'reference';
      const token = 'test-token';
      const path = '/api/Partner/transaction/request';
      final uri = Uri.https(Spenn.authority, path);
      final options = RequestOptions(path: path, baseUrl: Spenn.authority);
      const response = <String, dynamic>{
        r'$id': 'testing-ID',
        'requestId': 'testing-request-ID',
        'status': 'Pending',
        'externalReference': externalReference,
      };

      setUp(() {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            requestOptions: options,
            data: response,
            statusCode: 200,
          ),
        );
      });

      test('calls dio.postUri', () async {
        await spenn.createRequest(
          phoneNumber: phoneNumber,
          amount: amount,
          message: message,
          externalReference: externalReference,
          bearerToken: token,
        );

        verify(() => dio.postUri<Map<String, dynamic>>(uri,
            data: any(named: 'data'))).called(1);
      });

      test('throws a SpennHttpException when http request fails', () {
        when(() => dio.postUri(any(), data: any(named: 'data')))
            .thenThrow(Exception());
        expect(
          () => spenn.createRequest(
            phoneNumber: phoneNumber,
            amount: amount,
            message: message,
            externalReference: externalReference,
            bearerToken: token,
          ),
          throwsA(isA<SpennHttpException>()),
        );
      });

      test('throws a SpennHttpRequestFailure when the status code is not 200',
          () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: {},
            statusCode: 401,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
          () => spenn.createRequest(
            phoneNumber: phoneNumber,
            amount: amount,
            message: message,
            externalReference: externalReference,
            bearerToken: token,
          ),
          throwsA(isA<SpennHttpRequestFailure>()),
        );
      });

      test('throws a SpennTypeError when the response body is null', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: null,
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );

        expect(
            () => spenn.createRequest(
                  phoneNumber: phoneNumber,
                  amount: amount,
                  message: message,
                  externalReference: externalReference,
                  bearerToken: token,
                ),
            throwsA(isA<SpennTypeError>()));
      });

      test(
          'throws a SpennJsonDeserializationException when the response body '
          'has a non-supported pattern and fails to deserialize', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: {'not-a-token': 'i am a token'},
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
            () => spenn.createRequest(
                  phoneNumber: phoneNumber,
                  amount: amount,
                  message: message,
                  externalReference: externalReference,
                  bearerToken: token,
                ),
            throwsA(isA<SpennJsonDeserializationException>()));
      });
    });

    group('cancelRequest', () {
      const requestGuid = 'tesing-request-guid';
      const token = 'testing-token';
      const path = '/api/Partner/transaction/request/cancel';
      final uri = Uri.https(Spenn.authority, path);
      final options = RequestOptions(path: path, baseUrl: Spenn.authority);
      final response = <String, dynamic>{
        r'$id': 'testing-ID',
        'requestId': 'testing-request-ID',
        'status': 'Pending',
        'externalReference': 'external-reference',
      };

      setUp(() {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            requestOptions: options,
            data: response,
            statusCode: 200,
          ),
        );
      });
      test('calls dio.postUri', () async {
        await spenn.cancelRequest(requestGuid: requestGuid, token: token);

        verify(() => dio.postUri<Map<String, dynamic>>(uri,
            data: any(named: 'data'))).called(1);
      });

      test('throws a SpennHttpException when http request fails', () {
        when(() => dio.postUri(any(), data: any(named: 'data')))
            .thenThrow(Exception());
        expect(
          () => spenn.cancelRequest(requestGuid: requestGuid, token: token),
          throwsA(isA<SpennHttpException>()),
        );
      });

      test('throws a SpennHttpRequestFailure when the status code is not 200',
          () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: {},
            statusCode: 401,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
          () => spenn.cancelRequest(requestGuid: requestGuid, token: token),
          throwsA(isA<SpennHttpRequestFailure>()),
        );
      });
      test('throws a SpennTypeError when the response body is null', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: null,
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );

        expect(
            () => spenn.cancelRequest(requestGuid: requestGuid, token: token),
            throwsA(isA<SpennTypeError>()));
      });

      test(
          'throws a SpennJsonDeserializationException when the response body '
          'has a non-supported pattern and fails to deserialize', () {
        when(() => dio.postUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: {'not-a-token': 'i am a token'},
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
            () => spenn.cancelRequest(requestGuid: requestGuid, token: token),
            throwsA(isA<SpennJsonDeserializationException>()));
      });
    });

    group('checkRequestStatus', () {
      const requestGuid = 'request-guid';
      const token = 'test-token-i-guess';
      const path = '/api/Partner/transaction/request/$requestGuid';
      final uri = Uri.https(Spenn.authority, path);
      final options = RequestOptions(path: path, baseUrl: Spenn.authority);
      const response = <String, dynamic>{
        r'$id': 'id',
        'requestGuid': requestGuid,
        'requestStatus': 'request-status',
        'timestampCreated': '2021-08-31',
        'phoneNumber': '0780000000',
        'message': 'just for testing',
        'amount': 1299.99,
        'externalReference': 'external-reference',
        'transactionStatus': 'TransactionApproved',
      };

      setUp(() {
        dio.options.method = 'GET';
        when(() => dio.requestUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            requestOptions: options,
            data: response,
            statusCode: 200,
          ),
        );
      });

      test('calls dio.requestUri', () async {
        await spenn.checkRequestStatus(requestGuid: requestGuid, token: token);

        verify(() => dio.requestUri<Map<String, dynamic>>(uri,
            data: any(named: 'data'))).called(1);
      });

      test('throws a SpennHttpException when http request fails', () {
        when(() => dio.requestUri(any(), data: any(named: 'data')))
            .thenThrow(Exception());
        expect(
          () => spenn.checkRequestStatus(
            requestGuid: requestGuid,
            token: token,
          ),
          throwsA(isA<SpennHttpException>()),
        );
      });

      test('throws a SpennHttpRequestFailure when the status code is not 200',
          () {
        when(() => dio.requestUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: {},
            statusCode: 401,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
          () => spenn.checkRequestStatus(
            requestGuid: requestGuid,
            token: token,
          ),
          throwsA(isA<SpennHttpRequestFailure>()),
        );
      });

      test('throws a SpennTypeError when the response body is null', () {
        when(() => dio.requestUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: null,
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );

        expect(
            () => spenn.checkRequestStatus(
                  requestGuid: requestGuid,
                  token: token,
                ),
            throwsA(isA<SpennTypeError>()));
      });

      test(
          'throws a SpennJsonDeserializationException when the response body '
          'has a non-supported pattern and fails to deserialize', () {
        when(() => dio.requestUri(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            // ignore: avoid_redundant_argument_values
            data: {'not-a-token': 'i am a token'},
            statusCode: 200,
            requestOptions: options,
            statusMessage: 'failed',
          ),
        );
        expect(
            () => spenn.checkRequestStatus(
                  requestGuid: requestGuid,
                  token: token,
                ),
            throwsA(isA<SpennJsonDeserializationException>()));
      });
    });
  });
}
