import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starzinfinite/features/auth/domain/model.dart';
import 'package:starzinfinite/features/auth/presentation/controller/auth_provider.dart';

import '../../../../core/cores.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final user = authState.userInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mi Perfil",
          style: semibold(blackBeePay, 24),
        ),
        centerTitle: false,
        backgroundColor: blanco,
        surfaceTintColor: blanco,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderProfile(user: user),
            addVerticalSpace(32),
            Saldo(),
            addVerticalSpace(24),
            Settings(),
            addVerticalSpace(16),
            CustomButton(
              text: "Cerrar sesión",
              onPressed: () {
                authState.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              height: 50,
              width: double.infinity,
              color: starzAzulOscuro,
            ),
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Text(
            'Mi información',
            style: medium(blackBeePay, 18),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: gris7,
          ),
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Text(
            'Pagos',
            style: medium(blackBeePay, 18),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: gris7,
          ),
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Text(
            'Configuración',
            style: medium(blackBeePay, 18),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: gris7,
          ),
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Text(
            'Asistencia',
            style: medium(blackBeePay, 18),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: gris7,
          ),
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
      ],
    );
  }
}

class Saldo extends StatelessWidget {
  const Saldo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 0,
          color: gris2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // width: deviceWidth(context),
              child: Column(
                children: [
                  Text(
                    '12,000.00',
                    style: bold(starzAzulOscuro, 20),
                  ),
                  Text(
                    'saldo',
                    style: medium(gris7, 16),
                  ),
                ],
              ),
            ),
            Container(
                height: 100,
                child: VerticalDivider(
                  color: gris2,
                )),
            Container(
              // width: width * 0.5,
              child: Column(
                children: [
                  Text(
                    '12',
                    style: bold(starzAzulOscuro, 20),
                  ),
                  Text(
                    'emitidos',
                    style: medium(gris7, 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          color: gris2,
          height: 0,
        ),
      ],
    );
  }
}

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    super.key,
    required this.user,
  });

  final UserApp user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: starzAzul,
              child: Text(
                'F',
                style: medium(blanco, 20),
              ),
            ),
            addHorizontalSpace(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Usuario User Prueba",
                  style: semibold(starzAzulOscuro, 24),
                ),
                Text(
                  "Agencia Tia Chochis",
                  style: medium(gris7, 16),
                ),
              ],
            )
          ],
        ),
        addVerticalSpace(32),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: gris7,
            ),
            addHorizontalSpace(16),
            Text(
              user.username ?? 'No disponible',
              style: medium(gris7, 16),
            ),
          ],
        ),
        addVerticalSpace(16),
        Row(
          children: [
            Icon(
              Icons.email_outlined,
              color: gris7,
            ),
            addHorizontalSpace(16),
            Text(
              user.email ?? 'No disponible',
              style: medium(gris7, 16),
            ),
          ],
        ),
      ],
    );
  }
}
