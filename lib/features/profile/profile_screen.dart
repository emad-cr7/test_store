import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),

      body: Column(
        children: [
          SizedBox(height: 15),

          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          SizedBox(height: 15),

          Text(
            'Emad Marri',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Text('emad@example.com', style: TextStyle(color: Colors.grey)),

          SizedBox(height: 30),

          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Edit Profile'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
