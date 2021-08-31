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
    });
  });
}
