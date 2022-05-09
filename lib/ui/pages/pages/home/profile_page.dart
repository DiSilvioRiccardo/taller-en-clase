import 'package:f_local_database_shared_prefs_template/ui/pages/pages/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/authentication_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find();
    return Center(
        child: ElevatedButton(
      key: const Key('profileLogout'),
      child: const Text('Logout'),
      onPressed: () {
        controller.logout();
        Get.to(() => const LoginPage());
      },
    ));
  }
}
