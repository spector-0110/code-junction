import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key, required String username, this.profession = 'beginner'})
      : _userName = username;

  final String profession, _userName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(_userName),
      subtitle: Text(profession),
    );
  }
}
