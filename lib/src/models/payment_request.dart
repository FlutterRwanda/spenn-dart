import 'package:equatable/equatable.dart';

/// {@template payment_request}
/// A request from a business to a user to pay money to your Spenn
/// Business account. This can for example be to pay for
/// an invoice or to pay for an orde placed in an online shopping system
/// {@endtemplate payment_request}
class PaymentRequest extends Equatable {
  /// {@macro payment_request}
  /// Creates a new instance of [PaymentRequest]
  const PaymentRequest({
    required this.requestId,
    required this.id,
    required this.status,
    this.externalRef,
  });

  /// Generates a new instance of [PaymentRequest] from a given map of data
  factory PaymentRequest.fromMap(Map<String, dynamic> data) => PaymentRequest(
        requestId: "data['requestId'] as String",
        id: data[r'$id'] as String,
        status: data['status'] as String,
        externalRef: data['externalReference'],
      );

  /// ID
  final String id;

  /// ID of the payment request
  final String requestId;

  /// Status of the payment request
  final String status;

  /// External reference
  final String? externalRef;

  @override
  List<Object?> get props => [id, requestId, status, externalRef];

  /// Parses the current instance of [PaymentRequest]
  /// into a [Map<String,dynamic>]
  Map<String, dynamic> toMap() => <String, dynamic>{
        r'$id': id,
        'requestId': requestId,
        'status': status,
        'externalReference': externalRef,
      };

  /// Copies the current [PaymentRequest] while changing the specified fields.
  PaymentRequest copyWith({
    String? requestId,
    String? id,
    String? status,
    String? externalRef,
  }) =>
      PaymentRequest(
        requestId: requestId ?? this.requestId,
        id: id ?? this.id,
        status: status ?? this.status,
        externalRef: externalRef ?? this.externalRef,
      );
}
