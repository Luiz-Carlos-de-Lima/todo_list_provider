import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class HomeWeekFilter extends StatefulWidget {
  const HomeWeekFilter({super.key});

  @override
  State<HomeWeekFilter> createState() => _HomeWeekFilterState();
}

class _HomeWeekFilterState extends State<HomeWeekFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'DIA DA SEMANA',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 95,
          child: DatePicker(
            DateTime.now(),
            locale: 'pt_BR',
            height: 2,
            initialSelectedDate: DateTime.now(),
            selectionColor: context.primaryColor,
            selectedTextColor: Colors.white,
            daysCount: 7,
            monthTextStyle: TextStyle(fontSize: 8),
            dayTextStyle: TextStyle(fontSize: 13),
            dateTextStyle: TextStyle(fontSize: 13),
          ),
        )
      ],
    );
  }
}
