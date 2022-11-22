import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:get_it/get_it.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';

import 'package:contacts/model/user.dart';
import 'package:contacts/provider/user_provider.dart';

class InfoUserPage extends StatelessWidget {
  InfoUserPage({super.key, required this.id}) {
    init();
  }

  void init() async {
    if (id != null) {
      _user = await GetIt.instance<Isar>().users.get(id!) ?? User();
    } else {
      _user = User();
    }
  }

  final Id? id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final User _user;

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
                  if (id == null) {
                    context.read<UserProvider>().addUser(_user);
                    Navigator.of(context).pop();
                  }
                }
              },
              tooltip: 'Validate',
              icon: const Icon(Icons.check)),
        ],
      ),
      body: _InfoUserForm(
        formKey: _formKey,
        user: _user,
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
    _controllerName.addListener(() => widget.user.name = _controllerName.text);
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
            initialValue: widget.user.name,
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
            initialValue: widget.user.surname,
            decoration: const InputDecoration(
              hintText: 'Last Name',
              labelText: 'Last Name',
            ),
            controller: _controllerSurname,
          ),
          DateTimeFormField(
            initialDate: widget.user.birthDate,
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
