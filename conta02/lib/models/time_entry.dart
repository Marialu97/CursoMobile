import 'package:cloud_firestore/cloud_firestore.dart';

enum EntryType { entry, exit }

class TimeEntry {
  final String id;
  final String employeeId;
  final DateTime dateTime;
  final EntryType type;

  TimeEntry({
    required this.id,
    required this.employeeId,
    required this.dateTime,
    required this.type,
  });

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'employeeId': employeeId,
      'dateTime': Timestamp.fromDate(dateTime),
      'type': type.name,
    };
  }

  // Create from Firestore document
  factory TimeEntry.fromMap(String id, Map<String, dynamic> map) {
    return TimeEntry(
      id: id,
      employeeId: map['employeeId'] ?? '',
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      type: EntryType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => EntryType.entry,
      ),
    );
  }

  // Copy with method for updates
  TimeEntry copyWith({
    String? id,
    String? employeeId,
    DateTime? dateTime,
    EntryType? type,
  }) {
    return TimeEntry(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
    );
  }
}
