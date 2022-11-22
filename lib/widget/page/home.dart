import 'package:contacts/widget/page/info_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:contacts/provider/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: context
              .watch<UserProvider>()
              .users
              .map((user) => ListTile(
                    title: Text(user.name.toString()),
                    subtitle: user.surname != null
                        ? Text(user.surname.toString())
                        : null,
                    trailing: IconButton(
                      onPressed: () =>
                          context.read<UserProvider>().deleteUser(user),
                      icon: const Icon(Icons.delete),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InfoUserPage(user: user),
                        ),
                      );
                    },
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InfoUserPage(user: null),
            ),
          );
        },
        tooltip: 'Add a new user',
        child: const Icon(Icons.add),
      ),
    );
  }
}
