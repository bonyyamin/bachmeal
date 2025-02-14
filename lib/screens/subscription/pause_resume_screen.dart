import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:bachmeal/utils/date_helper.dart';
import 'package:table_calendar/table_calendar.dart';

class PauseResumeScreen extends StatefulWidget {
  const PauseResumeScreen({super.key});

  @override
  State<PauseResumeScreen> createState() => _PauseResumeScreenState();
}

class _PauseResumeScreenState extends State<PauseResumeScreen> {
  final Set<DateTime> _pausedDates = {};
  final Map<DateTime, Set<String>> _pausedMeals = {};

  void _togglePauseDate(DateTime date) {
    setState(() {
      if (_pausedDates.contains(date)) {
        _pausedDates.remove(date);
        _pausedMeals.remove(date);
      } else {
        _pausedDates.add(date);
        _pausedMeals[date] = {};
      }
    });
  }

  void _toggleMealPause(DateTime date, String meal) {
    setState(() {
      if (!_pausedMeals.containsKey(date)) {
        _pausedMeals[date] = {meal};
      } else {
        if (_pausedMeals[date]!.contains(meal)) {
          _pausedMeals[date]!.remove(meal);
          if (_pausedMeals[date]!.isEmpty) {
            _pausedMeals.remove(date);
            _pausedDates.remove(date);
          }
        } else {
          _pausedMeals[date]!.add(meal);
          _pausedDates.add(date);
        }
      }
    });
  }

  void _clearPauses() {
    setState(() {
      _pausedDates.clear();
      _pausedMeals.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("All pauses have been cleared!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        title: Text("Pause/Resume Service", style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.gold,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Days to Pause", style: AppTheme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 90)),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: AppTheme.textTheme.headlineMedium!,
              ),
              selectedDayPredicate: (date) => _pausedDates.contains(date),
              onDaySelected: (selectedDay, focusedDay) => _togglePauseDate(selectedDay),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppTheme.gold.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Pause Specific Meals", style: AppTheme.textTheme.headlineMedium),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _pausedDates.map((date) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateHelper.formatDate(date), style: AppTheme.textTheme.bodyLarge),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: ["Breakfast", "Lunch", "Dinner"].map((meal) {
                              bool isPaused = _pausedMeals[date]?.contains(meal) ?? false;
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isPaused ? Colors.red : AppTheme.gold,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () => _toggleMealPause(date, meal),
                                child: Text(meal),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _clearPauses,
              child: const Center(child: Text("Clear All Pauses")),
            ),
          ],
        ),
      ),
    );
  }
}
