import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/features/auth/presentation/controller/auth_provider.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final user = authState.userInfo;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Perfil",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text("Usuario: ${user.username ?? 'No disponible'}"),
          Text("Email: ${user.email ?? 'No disponible'}"),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authState.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
    );
  }
}
