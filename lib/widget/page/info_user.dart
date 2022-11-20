import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:styled_widget/styled_widget.dart';

class InfoUserPage extends StatelessWidget {
  InfoUserPage({super.key, required this.id});

  final Id? id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: id == null ? const Text('New user') : const Text('Change user'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // ajout ou modification de l'utilisateur
                }
              },
              tooltip: 'Validate',
              icon: const Icon(Icons.check)),
        ],
      ),
      body: _InfoUserForm(
        formKey: _formKey,
      ),
    );
  }
}

class _InfoUserForm extends StatefulWidget {
  const _InfoUserForm({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  State<_InfoUserForm> createState() => _InfoUserState();
}

class _InfoUserState extends State<_InfoUserForm> {
  _InfoUserState();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              decoration: const InputDecoration(
                hintText: 'First Name',
                labelText: 'First Name',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'A contact must have a first name';
                }
                return null;
              }),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Last Name',
              labelText: 'Last Name',
            ),
          ),
          InputDatePickerFormField(
            firstDate: DateTime.utc(1900, 1, 1),
            lastDate: DateTime.now(),
            fieldLabelText: 'Birthday',
          )
        ],
      ),
    ).padding(all: 8.0);
  }
}
