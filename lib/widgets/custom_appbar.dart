import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomAppBar(
      {super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        title: const Text('Subspace', style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
          return scaffoldKey.currentState?.openDrawer();
        }, icon: const Icon(Icons.menu, color: Colors.white,))
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
