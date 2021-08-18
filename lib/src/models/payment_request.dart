import 'package:equatable/equatable.dart';

/// {@template payment_request}
/// A request from a business to a user to pay money to your Spenn
/// Business account. This can for example be to pay for
/// an invoice or to pay for an orde placed in an online shopping system
/// {@endtemplate payment_request}
class PaymentRequest extends Equatable {
  /// {@macro payment_request}
  const PaymentRequest({
    required this.requestId,
    required this.id,
    required this.status,
  });

  /// Generates a new instance of [PaymentRequest] from a given map of data
  factory PaymentRequest.fromMap(Map<String, dynamic> data) => PaymentRequest(
        requestId: data['amount'] as String,
        id: data['phoneNumber'] as String,
        status: data['messsage'] as String,
      );

  /// ID
  final String id;

  /// ID of the payment request
  final String requestId;

  /// Status of the payment request
  final String status;

  @override
  List<Object?> get props => [id, requestId, status];

  /// Parses the current instance of [PaymentRequest]
  /// into a [Map<String,dynamic>]
  Map<String, dynamic> toMap() => <String, dynamic>{
        'phoneNumber': id,
        'amount': requestId,
        'message': status,
      };

  /// Copies the current [PaymentRequest] while changing the specified fields.
  PaymentRequest copyWith({
    String? requestId,
    String? id,
    String? status,
  }) =>
      PaymentRequest(
        requestId: requestId ?? this.requestId,
        id: id ?? this.id,
        status: status ?? this.status,
      );
}
