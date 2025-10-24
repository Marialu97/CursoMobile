import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/employee.dart';
import '../providers/employee_provider.dart';
import '../providers/auth_provider.dart';
import '../services/auth_service.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeProvider>().loadEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    // Only allow admin access
    if (!authProvider.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Access Denied')),
        body: const Center(
          child: Text('You do not have permission to view this page.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEmployeeDialog(context),
          ),
        ],
      ),
      body: employeeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: employeeProvider.employees.length,
              itemBuilder: (context, index) {
                final employee = employeeProvider.employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('${employee.email} - ${employee.role.name}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showEmployeeDialog(context, employee: employee),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEmployee(context, employee),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _showEmployeeDialog(BuildContext context, {Employee? employee}) {
    final nameController = TextEditingController(text: employee?.name ?? '');
    final emailController = TextEditingController(text: employee?.email ?? '');
    final positionController = TextEditingController(
      text: employee?.position ?? '',
    );
    final passwordController = TextEditingController();
    Role selectedRole = employee?.role ?? Role.employee;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(employee == null ? 'Add Employee' : 'Edit Employee'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value?.contains('@') ?? false ? null : 'Invalid email',
              ),
              TextFormField(
                controller: positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              if (employee == null) // Only show password for new employees
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                      (value?.length ?? 0) >= 6 ? null : 'Min 6 characters',
                ),
              DropdownButtonFormField<Role>(
                value: selectedRole,
                items: Role.values
                    .map(
                      (role) =>
                          DropdownMenuItem(value: role, child: Text(role.name)),
                    )
                    .toList(),
                onChanged: (value) => selectedRole = value!,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              final newEmployee = Employee(
                id: employee?.id ?? '', // Will be set when creating auth user
                name: nameController.text,
                email: emailController.text,
                role: selectedRole,
                position: positionController.text,
              );

              try {
                if (employee == null) {
                  // Create new employee with auth
                  // First create Firebase Auth user
                  final userCredential = await _authService
                      .signUpWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                      );

                  // Then create employee document with the auth UID
                  final employeeWithId = Employee(
                    id: userCredential.user!.uid,
                    name: nameController.text,
                    email: emailController.text,
                    role: selectedRole,
                    position: positionController.text,
                  );

                  await context.read<EmployeeProvider>().addEmployee(
                    employeeWithId,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Employee added successfully'),
                    ),
                  );
                } else {
                  await context.read<EmployeeProvider>().updateEmployee(
                    newEmployee,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Employee updated')),
                  );
                }
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteEmployee(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete ${employee.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await context.read<EmployeeProvider>().deleteEmployee(
                  employee.id,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Employee deleted')),
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
