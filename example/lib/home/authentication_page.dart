import 'package:flutter/material.dart';
import 'package:spenn/spenn.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late TextEditingController _clientIdController;
  late TextEditingController _clientSecretController;
  late TextEditingController _audienceController;
  late TextEditingController _apikeyController;
  late GlobalKey _formKey;
  late Spenn _spenn;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _clientIdController = TextEditingController();
    _clientSecretController = TextEditingController();
    _audienceController = TextEditingController();
    _apikeyController = TextEditingController();
    _formKey = GlobalKey<ScaffoldState>();
    _spenn = Spenn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('SPENN Business API')),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: _clientIdController,
                decoration: const InputDecoration(labelText: 'client ID'),
              ),
              TextFormField(
                controller: _clientSecretController,
                decoration: const InputDecoration(labelText: 'Client Secret'),
              ),
              TextFormField(
                controller: _apikeyController,
                decoration: const InputDecoration(labelText: 'API Key'),
              ),
              TextFormField(
                controller: _audienceController,
                decoration: const InputDecoration(labelText: 'Audience'),
              ),
              ElevatedButton(
                onPressed: () => _spenn
                    .authenticate(
                  apiKey: _apikeyController.text.trim(),
                  clientId: _clientIdController.text.trim(),
                  clientSecret: _clientSecretController.text.trim(),
                  audience: _audienceController.text.trim(),
                )
                    .then(
                  (session) {
                    print(session.toMap());
                    return ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Authentication succeeded'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ).onError(
                  (error, stackTrace) =>
                      ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failure!, $error'),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                child: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _clientIdController.dispose();
    _apikeyController.dispose();
    _audienceController.dispose();
    _clientSecretController.dispose();
    super.dispose();
  }
}
