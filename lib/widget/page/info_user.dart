import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

import 'package:contacts/model/user.dart';
import 'package:contacts/provider/user_provider.dart';

class InfoUserPage extends StatelessWidget {
  InfoUserPage({super.key, required this.user});

  final User? user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = this.user ?? User();
    return Scaffold(
      appBar: AppBar(
        title: this.user == null
            ? const Text('New user')
            : const Text('Change user'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // ajout ou modification de l'utilisateur
                  if (this.user == null) {
                    context.read<UserProvider>().addUser(user);
                  } else {
                    context.read<UserProvider>().updateUser(user);
                  }
                  Navigator.of(context).pop();
                }
              },
              tooltip: 'Validate',
              icon: const Icon(Icons.check)),
        ],
      ),
      body: _InfoUserForm(
        formKey: _formKey,
        user: user,
      ),
    );
  }
}

class _InfoUserForm extends StatefulWidget {
  const _InfoUserForm({required this.formKey, required this.user});

  final GlobalKey<FormState> formKey;
  final User user;

  @override
  State<_InfoUserForm> createState() => _InfoUserState();
}

class _InfoUserState extends State<_InfoUserForm> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.user.name != null) _controllerName.text = widget.user.name!;
    _controllerName.addListener(() => widget.user.name = _controllerName.text);
    if (widget.user.surname != null) {
      _controllerSurname.text = widget.user.surname!;
    }
    _controllerSurname
        .addListener(() => widget.user.surname = _controllerSurname.text);
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerSurname.dispose();
    super.dispose();
  }

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
            },
            controller: _controllerName,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Last Name',
              labelText: 'Last Name',
            ),
            controller: _controllerSurname,
          ),
          DateTimeFormField(
            initialValue: widget.user.birthDate,
            use24hFormat: true,
            firstDate: DateTime.utc(1900, 1, 1),
            lastDate: DateTime.now(),
            mode: DateTimeFieldPickerMode.date,
            autovalidateMode: AutovalidateMode.always,
            onDateSelected: (value) => widget.user.birthDate = value,
            decoration: const InputDecoration(
              labelText: 'Birthdate',
            ),
          )
        ],
      ),
    ).padding(all: 8.0);
  }
}
