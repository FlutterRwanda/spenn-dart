import 'package:flutter/material.dart';
import 'package:spenn/spenn.dart';

class PaymentRequestPage extends StatefulWidget {
  const PaymentRequestPage({Key? key}) : super(key: key);

  @override
  _PaymentRequestPageState createState() => _PaymentRequestPageState();
}

class _PaymentRequestPageState extends State<PaymentRequestPage> {
  final _spenn = Spenn();
  late TextEditingController _phoneNumberController;
  late TextEditingController _amountController;
  late TextEditingController _messageController;
  late TextEditingController _referenceController;
  late TextEditingController _apiKeyController;

  @override
  void initState() {
    _amountController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _messageController = TextEditingController();
    _referenceController = TextEditingController();
    _apiKeyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'PhoneNumber'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _messageController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Message'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _referenceController,
                decoration: const InputDecoration(
                  labelText: 'External Reference',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _apiKeyController,
                decoration: const InputDecoration(labelText: 'API Key'),
              ),
              ElevatedButton(
                onPressed: () => _spenn
                    .createRequest(
                      phoneNumber: _phoneNumberController.text.trim(),
                      amount: double.parse(_amountController.text),
                      message: _messageController.text.trim(),
                      externalReference: _referenceController.text,
                      token: _apiKeyController.text,
                    )
                    .then(
                      (payment) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Payment requested, '
                              'current status: ${payment.status}'),
                        ),
                      ),
                    )
                    .onError(
                  (error, stackTrace) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Failed ${error.toString()}'),
                      ),
                    );
                  },
                ),
                child: const Text('Create Request'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
