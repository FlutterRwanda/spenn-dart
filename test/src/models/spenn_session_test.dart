import 'package:spenn/src/models/spenn_session.dart';
import 'package:test/test.dart';

void main() {
  group('SpennSession', () {
    const token = 'random-token';
    const lifespan = 120000;
    final birth = DateTime.now();
    final death = DateTime.now().add(const Duration(milliseconds: 120000));
    const accountType = 'User';
    const clientId = 'client-ID';
    const refreshToken = 'refresh-token';
    final subject = SpennSession(
      token: token,
      lifespan: lifespan,
      birth: '$birth',
      death: '$death',
      accountType: accountType,
      clientId: clientId,
      refreshToken: refreshToken,
    );
    final testSubectData = <String, dynamic>{
      'access_token': token,
      'token_type': 'bearer',
      'expires_in': lifespan,
      'type': accountType,
      'clientId': clientId,
      'audience': null,
      'refresh_token': refreshToken,
      '.issued': '$birth',
      '.expires': '$death'
    };
    test('constructor returns normally', () {
      expect(
        () => SpennSession(
            token: token,
            lifespan: lifespan,
            birth: '$birth',
            death: '$death',
            accountType: accountType,
            clientId: clientId,
            refreshToken: refreshToken),
        returnsNormally,
      );
    });

    test('has value comparison', () {
      expect(
        SpennSession(
            token: token,
            lifespan: lifespan,
            birth: '$birth',
            death: '$death',
            accountType: accountType,
            clientId: clientId,
            refreshToken: refreshToken),
        equals(subject),
      );
    });

    group('.fromMap', () {
      test('create a new SpennSession object from given map of data', () {
        expect(SpennSession.fromMap(testSubectData), equals(subject));
      });
    });

    group('.toMap', () {
      test('parses a SpennSession object into a Map', () {
        expect(subject.toMap(), equals(testSubectData));
      });
    });

    group('.copyWith', () {
      test('copies a SpennSession object and update the specified fields', () {
        expect(
          subject.copyWith(clientId: 'another-ID'),
          equals(
            SpennSession(
              token: token,
              lifespan: lifespan,
              birth: '$birth',
              death: '$death',
              accountType: accountType,
              clientId: 'another-ID',
              refreshToken: refreshToken,
            ),
          ),
        );
      });
    });
  });
}
