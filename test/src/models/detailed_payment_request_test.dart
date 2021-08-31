import 'package:spenn/spenn.dart';
import 'package:test/test.dart';

void main() {
  group('DetailedPaymentRequest', () {
    const id = 'id';
    const requestGuid = 'request-guid';
    const requestStatus = 'Pending';
    const phoneNumber = '0780000000';
    const birthdatetime = '2021-08-31';
    const message = 'just testing this';
    const amount = 1234.98;
    const externalRef = 'external-reference';
    const transactionStatus = 'TransactionApproved';
    const subjectData = <String, dynamic>{
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
    const subject = DetailedPaymentRequest(
      id: id,
      requestGuid: requestGuid,
      birthdatetime: birthdatetime,
      phoneNumber: phoneNumber,
      amount: amount,
    );

    test('returns constructor normally', () {
      expect(
          () => const DetailedPaymentRequest(
              id: id,
              requestGuid: requestGuid,
              birthdatetime: birthdatetime,
              phoneNumber: phoneNumber,
              amount: amount),
          returnsNormally);
    });

    test('has value comparison', () {
      expect(
          const DetailedPaymentRequest(
              id: id,
              requestGuid: requestGuid,
              birthdatetime: birthdatetime,
              phoneNumber: phoneNumber,
              amount: amount),
          equals(subject));
    });

    group('.fromMap', () {
      test('creates a new DetailedPaymentRequest object from given map of data',
          () {
        expect(
          DetailedPaymentRequest.fromMap(subjectData),
          const DetailedPaymentRequest(
            id: id,
            requestGuid: requestGuid,
            birthdatetime: birthdatetime,
            phoneNumber: phoneNumber,
            amount: amount,
            externalRef: externalRef,
            message: message,
            requestStatus: requestStatus,
            transactionStatus: transactionStatus,
          ),
        );
      });
    });

    group('.toMap', () {
      test('parses a DetailedPaymentRequest object into Map', () {
        expect(
          const DetailedPaymentRequest(
            id: id,
            requestGuid: requestGuid,
            birthdatetime: birthdatetime,
            phoneNumber: phoneNumber,
            amount: amount,
            externalRef: externalRef,
            message: message,
            requestStatus: requestStatus,
            transactionStatus: transactionStatus,
          ).toMap(),
          equals(subjectData),
        );
      });
    });

    group('.copywith', () {
      test('copies a PaymentRequest object and update the specified fields',
          () {
        expect(
          subject.copyWith(amount: 5000),
          equals(
            const DetailedPaymentRequest(
              id: id,
              requestGuid: requestGuid,
              birthdatetime: birthdatetime,
              phoneNumber: phoneNumber,
              amount: 5000,
            ),
          ),
        );
      });
    });
  });
}
