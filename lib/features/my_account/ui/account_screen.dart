import 'package:flutter/material.dart';

import '../../../core/proxy/role_based_access_proxy.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
class AccountScreen extends StatelessWidget {
  final String? userRole; // Pass the user role to this screen

  const AccountScreen({
    Key? key,
    required this.userRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a proxy instance to handle access control
    final roleProxy = RoleBasedAccessProxy(userRole: userRole);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/userMale.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Admin-only options handled by the proxy
            if (userRole == "admin") ...[
              ListTile(
                leading: const Icon(Icons.people_outlined, color: MyColors.myLightBrown),
                title: Text(
                  'Manage Workers',
                  style: MyTextStyle.font16MainBrownRegular,
                ),
                trailing: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  textDirection: TextDirection.rtl,
                  color: MyColors.myLightBrown,
                ),
                onTap: () {
                  // Use the proxy to control access
                  roleProxy.manageWorkers(context);
                },
              ),
              const Divider(),

              ListTile(
                leading: const Icon(Icons.insert_chart_outlined, color: MyColors.myLightBrown),
                title: Text(
                  'Statistics',
                  style: MyTextStyle.font16MainBrownRegular,
                ),
                trailing: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  textDirection: TextDirection.rtl,
                  color: MyColors.myLightBrown,
                ),
                onTap: () {
                  // Use the proxy to control access
                  roleProxy.viewStatistics(context);
                },
              ),
              const Divider(),
            ],

            // Common options for both roles
            ListTile(
              leading: const Icon(Icons.manage_accounts_outlined, color: MyColors.myLightBrown),
              title: Text(
                'Manage Residents',
                style: MyTextStyle.font16MainBrownRegular,
              ),
              trailing: const Icon(
                Icons.arrow_back_ios_new_outlined,
                textDirection: TextDirection.rtl,
                color: MyColors.myLightBrown,
              ),
              onTap: () {
                Navigator.pushNamed(context, Routes.residentsScreen);
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // Close dialog
                          Navigator.pushReplacementNamed(context, Routes.loginScreen); // Navigate to login screen
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
