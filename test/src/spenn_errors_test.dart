import 'package:spenn/spenn.dart';
import 'package:test/test.dart';

void main() {
  const subject = SpennHttpRequestFailure(statusCode: 404, body: 'not found');
  group('.SpennHttpRequestFailure', () {
    test('has readble toString', () {
      expect(
        subject.toString(),
        equals('SpennHttpRequestFailure(status:404, body:not found)'),
      );
    });
  });
}
