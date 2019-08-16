import 'package:flutter/material.dart';
import 'package:schedule/src/utils/colors.dart';

class ScheduleInWeek extends Table {
  Table ScheduleInWeekView() {
    return Table(
      border: TableBorder.all(color: AppColors.textColorsPrimary),
      children: [
        _title_row(),
        _lession_row(lession_numb: '1-3'),
        _lession_row(lession_numb: '4-6'),
        _lession_row(lession_numb: '7-9'),
        _lession_row(lession_numb: '10-12'),
        _lession_row(lession_numb: '13-14'),
        _lession_row(lession_numb: '15-16'),
      ],
    );
  }

  TableRow _title_row() {
    return TableRow(children: [
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(''),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.2',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.3',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.4',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.5',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.6',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(3.0),
        alignment: Alignment.center,
        child: Text(
          'T.7',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  _lession_row({String lession_numb}) {
    return TableRow(children: [
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          lession_numb,
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.bold),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '1-3',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '1-3',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '1-3',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.0),
        child: Text(
          '1-3',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.textColorsPrimary,
              fontWeight: FontWeight.normal),
        ),
      ),
    ]);
  }
}
