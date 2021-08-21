/// Interface for all the exceptions thrown by the Spenn SDK
abstract class SpennException implements Exception {}

/// Thrown if an exception occurs while making an `http` request.
class SpennHttpException implements SpennException {}

/// {@template http_request_failure}
/// Thrown if an `http` request returns a non-200 status code.
/// {@endtemplate}
class SpennHttpRequestFailure implements SpennException {
  /// {@macro http_request_failure}
  const SpennHttpRequestFailure({required this.statusCode, this.body});

  /// The status code of the response.
  final int statusCode;

  /// Request's body
  final Map? body;
}

/// Thrown when an error occurs while decoding the response body.
class SpennJsonDecodeException implements SpennException {}

/// Thrown when an error occurs while deserializing the response body.
class SpennJsonDeserializationException implements SpennException {}
