import 'package:flutter/material.dart';

import '../routing/routes.dart';
// Proxy class to control access based on user role
class RoleBasedAccessProxy {
  final String? userRole; // User role passed to the proxy

  RoleBasedAccessProxy({this.userRole});

  // Function to handle access control for managing workers (admin-only access)
  void manageWorkers(BuildContext context) {
    if (userRole == "admin") {
      // Grant access to manage workers
      Navigator.pushNamed(context, Routes.workersScreen);
    } else {
      // Deny access and show a message (or perform another action)
      _showAccessDenied(context);
    }
  }

  // Function to handle access control for viewing statistics (admin-only access)
  void viewStatistics(BuildContext context) {
    if (userRole == "admin") {
      // Grant access to view statistics
      Navigator.pushNamed(context, Routes.statisticsScreen);
    } else {
      // Deny access and show a message (or perform another action)
      _showAccessDenied(context);
    }
  }

  // Common function to handle access denial (could show a dialog or a message)
  void _showAccessDenied(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Access Denied. Admins only.")),
    );
  }
}
