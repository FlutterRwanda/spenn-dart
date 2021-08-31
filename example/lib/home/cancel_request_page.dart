import 'package:flutter/material.dart';
import 'package:spenn/spenn.dart';

class CancelRequestPage extends StatefulWidget {
  const CancelRequestPage({Key? key}) : super(key: key);
  static Route open() => MaterialPageRoute<Widget>(
        builder: (_) => const CancelRequestPage(),
      );

  @override
  _CancelRequestPageState createState() => _CancelRequestPageState();
}

class _CancelRequestPageState extends State<CancelRequestPage> {
  final _spenn = Spenn();
  late TextEditingController _uidController;
  late TextEditingController _tokenController;
  final _formKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _uidController = TextEditingController();
    _tokenController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Request'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _uidController,
                decoration: const InputDecoration(
                  labelText: 'Request ID',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _tokenController,
                decoration: const InputDecoration(
                  labelText: 'Token',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _spenn
                    .cancelRequest(
                      requestGuid: _uidController.text.trim(),
                      token: _tokenController.text.trim(),
                    )
                    .then(
                      (payment) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Request ${_uidController.text} '
                              'cancelled, current status: ${payment.status}'),
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
                child: const Text('Cancel Request'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
