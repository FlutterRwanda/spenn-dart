import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _clientIdController;
  late TextEditingController _clientSecretController;
  late TextEditingController _audienceController;
  late TextEditingController _apikeyController;
  late GlobalKey _formKey;

  @override
  void initState() {
    super.initState();
    _clientIdController = TextEditingController();
    _clientSecretController = TextEditingController();
    _audienceController = TextEditingController();
    _apikeyController = TextEditingController();
    _formKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () {},
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
    super.dispose();
  }
}
