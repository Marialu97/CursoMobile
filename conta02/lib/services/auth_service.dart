import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password (for admin to create employees)
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get employee role from Firestore
  Future<Employee?> getEmployeeData(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('employees')
          .doc(uid)
          .get();
      if (doc.exists) {
        return Employee.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting employee data: $e');
      return null;
    }
  }

  // Create employee document in Firestore
  Future<void> createEmployee(Employee employee) async {
    await _firestore
        .collection('employees')
        .doc(employee.id)
        .set(employee.toMap());
  }

  // Check if user is admin
  Future<bool> isAdmin(String uid) async {
    Employee? employee = await getEmployeeData(uid);
    return employee?.role == Role.admin;
  }

  // Create default admin user if not exists
  Future<void> createDefaultAdmin() async {
    const String adminEmail = 'admin@contacerta.com';
    const String adminPassword = 'admin123';
    const String adminName = 'Administrador';

    try {
      // Try to sign in first to check if user exists
      await _auth.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      );
      // If successful, user exists, sign out
      await _auth.signOut();
    } catch (e) {
      // User doesn't exist, create it
      try {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: adminEmail,
          password: adminPassword,
        );

        // Create employee document
        Employee adminEmployee = Employee(
          id: credential.user!.uid,
          name: adminName,
          email: adminEmail,
          role: Role.admin,
          position: 'Administrador',
        );
        await createEmployee(adminEmployee);
        print('Default admin user created successfully');
      } catch (createError) {
        print('Error creating default admin: $createError');
      }
    }
  }
}
