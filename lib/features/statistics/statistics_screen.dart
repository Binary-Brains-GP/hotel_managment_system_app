import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:design_pattern/core/networking/resident_payment_provider.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  double _filteredIncomeResidents = 0;
  String _selectedTimeframe = 'Yearly'; // Default selection

  @override
  void initState() {
    super.initState();
    _calculateFilteredIncome();
  }

  void _calculateFilteredIncome() {
    final residentPaymentProvider =
    Provider.of<ResidentPaymentProvider>(context, listen: false);

    final now = DateTime.now();

    // Filter based on the selected timeframe
    switch (_selectedTimeframe) {
      case 'Yearly':
        _filteredIncomeResidents =
            residentPaymentProvider.calculateIncomeForPeriod(
              startDate: DateTime(now.year, 1, 1),
              endDate: DateTime(now.year, 12, 31),
            );
        break;
      case 'Monthly':
        _filteredIncomeResidents =
            residentPaymentProvider.calculateIncomeForPeriod(
              startDate: DateTime(now.year, now.month, 1),
              endDate: DateTime(now.year, now.month + 1, 0),
            );
        break;
      case 'Daily':
        _filteredIncomeResidents =
            residentPaymentProvider.calculateIncomeForPeriod(
              startDate: DateTime(now.year, now.month, now.day),
              endDate: DateTime(now.year, now.month, now.day, 23, 59, 59),
            );
        break;
    }

    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedTimeframe,
              items: ['Yearly', 'Monthly', 'Daily']
                  .map((timeframe) => DropdownMenuItem<String>(
                value: timeframe,
                child: Text(timeframe),
              ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTimeframe = newValue!;
                });
                _calculateFilteredIncome();
              },
            ),
            SizedBox(height: 20),
            Text(
              'Filtered Income from Residents: \$${_filteredIncomeResidents.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
