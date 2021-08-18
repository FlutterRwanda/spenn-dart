import 'package:equatable/equatable.dart';

/// {@template spenn_session}
/// Instance of session that holds the data returned after authentication.
/// {@endtemplate spenn_session}
class SpennSession extends Equatable {
  /// {@macro spenn_session}
  const SpennSession({
    required this.token,
    this.tokenType = 'bearer',
    required this.lifespan,
    this.audience,
    required this.birth,
    required this.death,
    required this.accountType,
    required this.clientId,
    required this.refreshToken,
  });

  /// Generates a new instance of [SpennSession] from a given map of data
  factory SpennSession.fromMap(Map<String, dynamic> data) {
    return SpennSession(
      token: data['access_token'] as String,
      tokenType: data['token_type'] as String,
      lifespan: data['expires_in'] as int,
      accountType: data['type'] as String,
      clientId: data['clientId'] as String,
      audience: data['audience'] as String?,
      refreshToken: data['refresh_token'] as String,
      birth: data['.issued'] as String,
      death: data['.expires'] as String,
    );
  }

  /// Access token
  final String token;

  /// The type of the access token
  final String tokenType;

  /// The token's lifespan in milliseconds
  final int lifespan;

  /// Refresh token
  final String refreshToken;

  /// The client's ID
  final String clientId;

  /// The Business audience
  final String? audience;

  /// The type of account that just authenticated
  final String accountType;

  /// Date time when the token was issued
  final String birth;

  /// Date time when the token will expire
  final String death;

  @override
  List<Object?> get props => [
        token,
        tokenType,
        lifespan,
        refreshToken,
        clientId,
        audience,
        accountType,
        birth,
        death
      ];

  /// Parses the current instance of [SpennSession] into a [Map<String,dynamic>]
  Map<String, dynamic> toMap() => <String, dynamic>{
        'access__token': token,
        'token_type': tokenType,
        'expires_in': lifespan,
        'type': accountType,
        'clientId': clientId,
        'audience': audience,
        'refresh_token': refreshToken,
        '.issued': birth,
        '.expires': death,
      };

  /// Copies the current [SpennSession] while changing the specified fields
  SpennSession copyWith({
    String? token,
    String? tokenType,
    int? lifespan,
    String? audience,
    String? birth,
    String? death,
    String? accountType,
    String? clientId,
    String? refreshToken,
  }) =>
      SpennSession(
        token: token ?? this.token,
        lifespan: lifespan ?? this.lifespan,
        birth: birth ?? this.birth,
        death: death ?? this.death,
        accountType: accountType ?? this.accountType,
        clientId: clientId ?? this.clientId,
        refreshToken: refreshToken ?? this.refreshToken,
        audience: audience ?? this.audience,
        tokenType: tokenType ?? this.tokenType,
      );
}
