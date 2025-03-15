import 'package:flutter/material.dart';
import 'package:starzinfinite/core/cores.dart';

class AppBarStarz extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: starzAzul, size: 30),
      surfaceTintColor: Colors.white,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Container(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.popUntil(context, ModalRoute.withName('/a')),
          child: Image.asset(
            'assets/starz_logo.png',
            fit: BoxFit.contain,
            height: 60,
          ),
        ),
      ),
    );
  }
}
