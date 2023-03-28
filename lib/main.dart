import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() => runApp(const DateSelection());

class DateSelection extends StatelessWidget {
  const DateSelection({Key? key}) : super(key: key);
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  DateSelectionPicker(),
    );
  }
}

class DateSelectionPicker extends StatefulWidget {
  const DateSelectionPicker({Key? key}) : super(key: key);
  @override
  DateSelectionPickerState createState() => DateSelectionPickerState();
}

class DateSelectionPickerState extends State<DateSelectionPicker> {
  late List<DateTime> _activeDates;
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    _activeDates = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2)),
      today.add(const Duration(days: 3)),
      today.add(const Duration(days: 4)),
      today.add(const Duration(days: 5)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: SfDateRangePicker(
                controller: _controller,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                initialSelectedRange:
                PickerDateRange(_activeDates[0], _activeDates[5]),
                startRangeSelectionColor: Colors.purple,
                endRangeSelectionColor: Colors.purple,
                rangeSelectionColor: Colors.purpleAccent,
                onSelectionChanged: selectionChanged,
                selectableDayPredicate: predicateCallback,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                    disabledDatesTextStyle: TextStyle(
                        color: Colors.black87, fontSize: 13, fontFamily: 'Roboto')),
              ),
            )
          ],
        ));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _controller.selectedRange =
        PickerDateRange(_activeDates[0], _activeDates[5]);
  }

  bool predicateCallback(DateTime date) {
    for (int i = 0; i < _activeDates.length; i++) {
      if (_activeDates[i] == date) {
        return true;
      }
    }
    return false;
  }
}