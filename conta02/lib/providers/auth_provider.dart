import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/employee.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  Employee? _employee;
  bool _isLoading = false;

  User? get user => _user;
  Employee? get employee => _employee;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _employee?.role == Role.admin;

  AuthProvider() {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  void _onAuthStateChanged(User? user) async {
    _user = user;
    if (user != null) {
      _employee = await _authService.getEmployeeData(user.uid);
    } else {
      _employee = null;
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password, Employee employee) async {
    _isLoading = true;
    notifyListeners();
    try {
      UserCredential credential = await _authService.signUpWithEmailAndPassword(
        email,
        password,
      );
      employee = employee.copyWith(id: credential.user!.uid);
      await _authService.createEmployee(employee);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
