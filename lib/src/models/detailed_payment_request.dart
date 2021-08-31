import 'package:equatable/equatable.dart';
import 'package:spenn/src/models/payment_request.dart';

/// {@template payment_request_info}
/// A more detailed [PaymentRequest] model with more information
/// {@endtemplate payment_request}
class DetailedPaymentRequest with EquatableMixin {
  /// {@macro payment_request_info}
  /// Creates a new instance of [DetailedPaymentRequest]
  const DetailedPaymentRequest({
    required this.id,
    required this.requestGuid,
    this.requestStatus,
    required this.birthdatetime,
    required this.phoneNumber,
    this.message,
    required this.amount,
    this.externalRef,
    this.transactionStatus,
  });

  /// Generates a new instance of [DetailedPaymentRequest] from a
  /// given map of data
  factory DetailedPaymentRequest.fromMap(Map<String, dynamic> data) {
    return DetailedPaymentRequest(
      id: data[r'$id'] as String,
      requestGuid: data['requestGuid'] as String,
      birthdatetime: data['timestampCreated'] as String,
      phoneNumber: data['phoneNumber'] as String,
      amount: data['amount'] as double,
      externalRef: data['externalReference'] as String?,
      message: data['message'] as String?,
      requestStatus: data['requestStatus'] as String?,
      transactionStatus: data['transactionStatus'] as String?,
    );
  }

  /// ID
  final String id;

  /// Request uid
  final String requestGuid;

  /// Request status
  final String? requestStatus;

  /// Date Time when the request was created
  final String birthdatetime; //FIXME: shouldn't be a string

  /// Phone number
  final String phoneNumber;

  /// Message attached to the request
  final String? message;

  /// Amount
  final double amount;

  /// External reference
  final String? externalRef;

  /// Transation status
  final String? transactionStatus;

  @override
  List<Object?> get props => [
        id,
        requestGuid,
        requestGuid,
        birthdatetime,
        phoneNumber,
        message,
        amount,
        externalRef,
        transactionStatus,
      ];

  /// Parses this instance of [DetailedPaymentRequest] into a [Map]
  Map<String, dynamic> toMap() => <String, dynamic>{
        r'$id': id,
        'requestGuid': requestGuid,
        'requestStatus': requestStatus,
        'timestampCreated': birthdatetime,
        'phoneNumber': phoneNumber,
        'message': message,
        'amount': amount,
        'externalReference': externalRef,
        'transactionStatus': transactionStatus,
      };

  /// Copies the current [DetailedPaymentRequest]
  /// while changing the specified fields.
  DetailedPaymentRequest copyWith({
    String? id,
    String? requestGuid,
    String? requestStatus,
    String? birthdatetime,
    String? phoneNumber,
    String? message,
    double? amount,
    String? externalRef,
    String? transactionStatus,
  }) =>
      DetailedPaymentRequest(
        id: id ?? this.id,
        requestGuid: requestGuid ?? this.requestGuid,
        birthdatetime: birthdatetime ?? this.birthdatetime,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        amount: amount ?? this.amount,
        externalRef: externalRef ?? this.externalRef,
        message: message ?? this.message,
        requestStatus: requestStatus ?? this.requestStatus,
        transactionStatus: transactionStatus ?? this.transactionStatus,
      );
}
