import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee.dart';
import '../models/time_entry.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Employees CRUD
  Future<List<Employee>> getEmployees() async {
    QuerySnapshot snapshot = await _firestore.collection('employees').get();
    return snapshot.docs
        .map(
          (doc) => Employee.fromMap(doc.id, doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  Future<Employee?> getEmployee(String id) async {
    DocumentSnapshot doc = await _firestore
        .collection('employees')
        .doc(id)
        .get();
    if (doc.exists) {
      return Employee.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> addEmployee(Employee employee) async {
    await _firestore
        .collection('employees')
        .doc(employee.id)
        .set(employee.toMap());
  }

  Future<void> updateEmployee(Employee employee) async {
    await _firestore
        .collection('employees')
        .doc(employee.id)
        .update(employee.toMap());
  }

  Future<void> deleteEmployee(String id) async {
    await _firestore.collection('employees').doc(id).delete();
  }

  // Time Entries CRUD
  Future<List<TimeEntry>> getTimeEntries(
    String employeeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query query = _firestore
        .collection('time_entries')
        .where('employeeId', isEqualTo: employeeId);

    if (startDate != null) {
      query = query.where(
        'dateTime',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }
    if (endDate != null) {
      query = query.where(
        'dateTime',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    QuerySnapshot snapshot = await query
        .orderBy('dateTime', descending: true)
        .get();
    return snapshot.docs
        .map(
          (doc) =>
              TimeEntry.fromMap(doc.id, doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<TimeEntry>> getAllTimeEntries({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    Query query = _firestore.collection('time_entries');

    if (startDate != null) {
      query = query.where(
        'dateTime',
        isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
      );
    }
    if (endDate != null) {
      query = query.where(
        'dateTime',
        isLessThanOrEqualTo: Timestamp.fromDate(endDate),
      );
    }

    QuerySnapshot snapshot = await query
        .orderBy('dateTime', descending: true)
        .get();
    return snapshot.docs
        .map(
          (doc) =>
              TimeEntry.fromMap(doc.id, doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    await _firestore.collection('time_entries').add(entry.toMap());
  }

  // Calculate hours worked for a day
  double calculateHoursWorked(List<TimeEntry> entries, DateTime date) {
    List<TimeEntry> dayEntries = entries
        .where(
          (entry) =>
              entry.dateTime.year == date.year &&
              entry.dateTime.month == date.month &&
              entry.dateTime.day == date.day,
        )
        .toList();

    dayEntries.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    double totalHours = 0;
    DateTime? entryTime;

    for (var entry in dayEntries) {
      if (entry.type == EntryType.entry) {
        entryTime = entry.dateTime;
      } else if (entry.type == EntryType.exit && entryTime != null) {
        totalHours += entry.dateTime.difference(entryTime).inMinutes / 60.0;
        entryTime = null;
      }
    }

    return totalHours;
  }

  // Get last entry type for auto-suggestion
  Future<EntryType> getLastEntryType(String employeeId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('time_entries')
        .where('employeeId', isEqualTo: employeeId)
        .orderBy('dateTime', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      TimeEntry lastEntry = TimeEntry.fromMap(
        snapshot.docs.first.id,
        snapshot.docs.first.data() as Map<String, dynamic>,
      );
      return lastEntry.type == EntryType.entry
          ? EntryType.exit
          : EntryType.entry;
    }
    return EntryType.entry; // Default to entry if no previous entries
  }
}
