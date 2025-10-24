import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/firestore_service.dart';

class EmployeeProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Employee> _employees = [];
  bool _isLoading = false;

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;

  Future<void> loadEmployees() async {
    _isLoading = true;
    notifyListeners();
    try {
      _employees = await _firestoreService.getEmployees();
    } catch (e) {
      print('Error loading employees: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      await _firestoreService.addEmployee(employee);
      await loadEmployees(); // Reload list
    } catch (e) {
      print('Error adding employee: $e');
      rethrow;
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await _firestoreService.updateEmployee(employee);
      await loadEmployees(); // Reload list
    } catch (e) {
      print('Error updating employee: $e');
      rethrow;
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await _firestoreService.deleteEmployee(id);
      await loadEmployees(); // Reload list
    } catch (e) {
      print('Error deleting employee: $e');
      rethrow;
    }
  }
}
