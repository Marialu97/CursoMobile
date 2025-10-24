import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conta Certa - Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${authProvider.employee?.name ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Role: ${authProvider.employee?.role.name ?? 'Unknown'}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 40),
            if (authProvider.isAdmin) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/employees');
                },
                child: const Text('Manage Employees'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/reports');
                },
                child: const Text('View Reports'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/time_tracking');
                },
                child: const Text('Time Tracking'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/history');
                },
                child: const Text('View History'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
