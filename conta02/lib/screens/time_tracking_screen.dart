import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/auth_provider.dart';
import '../providers/time_entry_provider.dart';

class TimeTrackingScreen extends StatefulWidget {
  const TimeTrackingScreen({super.key});

  @override
  State<TimeTrackingScreen> createState() => _TimeTrackingScreenState();
}

class _TimeTrackingScreenState extends State<TimeTrackingScreen> {
  EntryType _suggestedType = EntryType.entry;

  @override
  void initState() {
    super.initState();
    _loadSuggestedType();
  }

  Future<void> _loadSuggestedType() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      final timeEntryProvider = Provider.of<TimeEntryProvider>(
        context,
        listen: false,
      );
      final suggested = await timeEntryProvider.getSuggestedEntryType(
        authProvider.user!.uid,
      );
      setState(() {
        _suggestedType = suggested;
      });
    }
  }

  Future<void> _registerTimeEntry() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final timeEntryProvider = Provider.of<TimeEntryProvider>(
      context,
      listen: false,
    );

    if (authProvider.user == null) return;

    final entry = TimeEntry(
      id: '', // Will be set by Firestore
      employeeId: authProvider.user!.uid,
      dateTime: DateTime.now(),
      type: _suggestedType,
    );

    try {
      await timeEntryProvider.addTimeEntry(entry);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_suggestedType.name.toUpperCase()} registered successfully',
          ),
        ),
      );
      // Update suggested type
      await _loadSuggestedType();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Time Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      'Current Time',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    StreamBuilder<DateTime>(
                      stream: Stream.periodic(
                        const Duration(seconds: 1),
                        (_) => DateTime.now(),
                      ),
                      builder: (context, snapshot) {
                        final now = snapshot.data ?? DateTime.now();
                        return Text(
                          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontFamily: 'monospace'),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Suggested Action: ${_suggestedType.name.toUpperCase()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registerTimeEntry,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: _suggestedType == EntryType.entry
                              ? Colors.green
                              : Colors.red,
                        ),
                        child: Text(
                          'Register ${_suggestedType.name.toUpperCase()}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              child: const Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
