/// Interface for all the exceptions thrown by the Spenn SDK
abstract class SpennException implements Exception {}

/// Thrown if an exception occurs while making an `http` request.
class SpennHttpException implements SpennException {}

/// {@template http_request_failure}
/// Thrown if an `http request returns a non-200` status code.
/// {@endtemplate}
class SpennHttpRequestFailure implements SpennException {
  /// {@macro http_request_failure}
  const SpennHttpRequestFailure({required this.statusCode, this.body});

  /// The status code of the response.
  final int? statusCode;

  /// Request's body
  final Object? body;

  @override
  String toString() => 'SpennHttpRequestFailure'
      '(status:$statusCode, body:$body)';
}

/// Thrown when the request is successfull but the body of an unexpected type.
///
/// If the response body expected is a [Map] but instead.
/// we get a [List] for example. Also  thrown when the response body is `null`.
class SpennTypeError implements SpennException {}

/// Thrown when an error occurs while deserializing the response body.
class SpennJsonDeserializationException implements SpennException {}
