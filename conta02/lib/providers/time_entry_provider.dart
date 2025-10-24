import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../services/firestore_service.dart';

class TimeEntryProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<TimeEntry> _timeEntries = [];
  bool _isLoading = false;

  List<TimeEntry> get timeEntries => _timeEntries;
  bool get isLoading => _isLoading;

  Future<void> loadTimeEntries(
    String employeeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      _timeEntries = await _firestoreService.getTimeEntries(
        employeeId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error loading time entries: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadAllTimeEntries({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      _timeEntries = await _firestoreService.getAllTimeEntries(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error loading all time entries: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    try {
      await _firestoreService.addTimeEntry(entry);
      // Reload entries for the employee
      await loadTimeEntries(entry.employeeId);
    } catch (e) {
      print('Error adding time entry: $e');
      rethrow;
    }
  }

  Future<EntryType> getSuggestedEntryType(String employeeId) async {
    return await _firestoreService.getLastEntryType(employeeId);
  }

  double calculateHoursWorked(DateTime date) {
    return _firestoreService.calculateHoursWorked(_timeEntries, date);
  }
}
