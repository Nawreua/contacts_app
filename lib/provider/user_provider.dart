import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:contacts/model/user.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    init();
  }

  List<User> _users = [];

  List<User> get users => _users;

  void init() async {
    await GetIt.instance<Isar>().txn(() async {
      _users = await GetIt.instance<Isar>().users.where().findAll();
      notifyListeners();
    });
  }

  void addUser(User user) async {
    await GetIt.instance<Isar>().writeTxn(() async {
      await GetIt.instance<Isar>().users.put(user);
    });
    _users.add(user);
    notifyListeners();
  }

  void deleteUser(User user) async {
    await GetIt.instance<Isar>().writeTxn(() async {
      if (await GetIt.instance<Isar>().users.delete(user.id)) {
        _users.remove(user);
        notifyListeners();
      }
    });
  }
}
