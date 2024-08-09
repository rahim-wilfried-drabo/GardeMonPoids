import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/weight_entry.dart';

class WeightChart extends StatelessWidget {
  final List<WeightEntry> entries;

  WeightChart({required this.entries});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<WeightEntry, DateTime>> series = [
      charts.Series(
        id: 'Weight',
        data: entries,
        domainFn: (WeightEntry entry, _) => entry.date,
        measureFn: (WeightEntry entry, _) => entry.weight,
      )
    ];

    return charts.TimeSeriesChart(series, animate: true);
  }
}
