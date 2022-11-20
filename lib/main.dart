import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';

import 'package:contacts/model/user.dart';
import 'package:contacts/widget/contacts_app.dart';
import 'package:contacts/provider/user_provider.dart';

void main() {
  setup();
  runApp(ChangeNotifierProvider(
    create: (_) => UserProvider(),
    child: const ContactsApp(),
  ));
}

void setup() async {
  GetIt.I.registerSingleton<Isar>(await Isar.open([UserSchema]));
}
