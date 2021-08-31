import 'package:example/home/authentication_page.dart';
import 'package:example/home/cancel_request_page.dart';
import 'package:example/home/payment_request_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPENN Business API')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push<Route>(
                MaterialPageRoute(builder: (_) => const AuthenticationPage()),
              ),
              child: const Text('Authentication'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push<Route>(
                  MaterialPageRoute(
                      builder: (_) => const PaymentRequestPage())),
              child: const Text('Payment Request'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push<dynamic>(CancelRequestPage.open()),
              child: const Text('Cancel Request'),
            )
          ],
        ),
      ),
    );
  }
}
