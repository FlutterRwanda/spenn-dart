import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:spenn/spenn.dart';
import 'package:spenn/src/spenn_errors.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client httpClient;
  late Spenn subject;

  group('Spenn', () {
    setUp(() {
      httpClient = MockHttpClient();
      subject = Spenn(httpClient: httpClient);
    });

    setUpAll(() {
      registerFallbackValue<Uri>(Uri());
    });

    test('returns constructor normally', () {
      expect(() => Spenn(), returnsNormally);
    });

    group('.authenticate', () {
      const apiKey = 'api-key';
      const clientId = 'client-id';
      const clientSecret = '1234';
      const audience = 'audience';
      const path = '/token';
      const responseBody = <String, dynamic>{
        'access_token': 'token',
        'token_type': 'bearer',
        'expires_in': 1199,
        'refresh_token': 'random stuff',
        'clientId': 'randomClientID',
        'audience': audience,
        'type': 'user',
        '.ssued': 'Sat, 21, 2021 10:12:00 GMT',
        '.expires': 'Sat, 21, 2021 10:12:00 GMT'
      };

      const headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      setUp(() {
        when(
          () => httpClient.post(
            any(),
            body: any(named: 'body'),
            headers: headers,
          ),
        ).thenAnswer(
          (_) async => http.Response(json.encode(responseBody), 200),
        );
      });

      test('calls httpClient.post', () async {
        await subject.authenticate(
          apiKey: apiKey,
          audience: audience,
          clientId: clientId,
          clientSecret: clientSecret,
        );
        verify(
          () => httpClient.post(Uri.https(Spenn.authority, path),
              body: any(named: 'body'), headers: headers),
        ).called(1);
      });
      test('throws a SpenHttpException when http request fails', () {
        when(() => httpClient.post(any(), body: any(named: 'body')))
            .thenThrow(SpennHttpException());
      });
    });
  });
}
