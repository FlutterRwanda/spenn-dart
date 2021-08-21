import 'package:spenn/src/models/payment_request.dart';
import 'package:test/test.dart';

void main() {
  group('PaymentRequest', () {
    const requestId = 'request-id';
    const id = 'test-id';
    const status = 'pending';

    const subject = PaymentRequest(
      requestId: requestId,
      id: id,
      status: status,
    );

    const testSubjectData = <String, dynamic>{
      r'$id': id,
      'requestId': requestId,
      'status': status,
    };

    test('returns constructor normally', () {
      expect(
        () =>
            const PaymentRequest(requestId: requestId, id: id, status: status),
        returnsNormally,
      );
    });

    test('has value comparison', () {
      expect(
        const PaymentRequest(requestId: requestId, id: id, status: status),
        equals(subject),
      );
    });

    group('.fromMap', () {
      test('create a new PaymentRequest object from given map of data', () {
        expect(PaymentRequest.fromMap(testSubjectData), equals(subject));
      });
    });

    group('.toMap', () {
      test('parses a PaymentRequest object into a Map', () {
        expect(subject.toMap(), equals(testSubjectData));
      });
    });

    group('.copyWith', () {
      test('copies a PaymentRequest object and update the specified fields',
          () {
        expect(
          subject.copyWith(status: 'Failed'),
          equals(
            const PaymentRequest(
                requestId: requestId, id: id, status: 'Failed'),
          ),
        );
      });
    });
  });
}
