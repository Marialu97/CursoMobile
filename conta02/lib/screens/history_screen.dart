import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../providers/auth_provider.dart';
import '../providers/time_entry_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final timeEntryProvider = Provider.of<TimeEntryProvider>(
      context,
      listen: false,
    );

    if (authProvider.user != null) {
      if (authProvider.isAdmin) {
        await timeEntryProvider.loadAllTimeEntries();
      } else {
        await timeEntryProvider.loadTimeEntries(authProvider.user!.uid);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final timeEntryProvider = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Hours Worked: ${timeEntryProvider.calculateHoursWorked(_selectedDate).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: timeEntryProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : timeEntryProvider.timeEntries.isEmpty
                ? const Center(child: Text('No entries found'))
                : ListView.builder(
                    itemCount: timeEntryProvider.timeEntries.length,
                    itemBuilder: (context, index) {
                      final entry = timeEntryProvider.timeEntries[index];
                      return ListTile(
                        leading: Icon(
                          entry.type == EntryType.entry
                              ? Icons.login
                              : Icons.logout,
                          color: entry.type == EntryType.entry
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(
                          '${entry.type.name.toUpperCase()} - ${DateFormat('HH:mm:ss').format(entry.dateTime)}',
                        ),
                        subtitle: Text(
                          DateFormat('yyyy-MM-dd').format(entry.dateTime),
                        ),
                        trailing: authProvider.isAdmin
                            ? Text('ID: ${entry.employeeId.substring(0, 8)}...')
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
