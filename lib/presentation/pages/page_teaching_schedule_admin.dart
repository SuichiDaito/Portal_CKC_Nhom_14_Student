import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_ckc/api/model/student_time_table_model.dart';
import 'package:portal_ckc/bloc/bloc_event_state/time_table_bloc.dart';
import 'package:portal_ckc/bloc/event/time_table_event.dart';
import 'package:portal_ckc/bloc/state/student_time_table_state.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_day_selector.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_print_schedule_dialog.dart';
import 'package:portal_ckc/presentation/sections/card/teaching_schedule_view.dart';
import 'package:portal_ckc/presentation/sections/schedule_management_dropdown_item.dart';
import 'package:portal_ckc/presentation/sections/schedule_management_dropdown_selector.dart';

class Subject {
  final String name;
  final String className;
  final String type;
  final String room;
  final String period;

  Subject(this.name, this.className, this.type, this.room, this.period);
}

class PageTeachingScheduleAdmin extends StatefulWidget {
  @override
  _PageTeachingScheduleAdminState createState() =>
      _PageTeachingScheduleAdminState();
}

class _PageTeachingScheduleAdminState extends State<PageTeachingScheduleAdmin> {
  int selectedWeek = 1;
  String? selectedDay;
  List<DropdownItem> _schoolYears = [];
  DropdownItem? _selectedSchoolYear;
  bool _isSchoolYearLoaded = false;

  List<DropdownItem> _weeks = [];
  DropdownItem? _selectedWeek;

  Map<String, Map<String, List<Subject>>> convertToScheduleData(
    List<ScheduleData> list,
    int selectedWeekId,
  ) {
    final Map<String, Map<String, List<Subject>>> result = {
      'Thứ 2': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 3': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 4': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 5': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 6': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Thứ 7': {'Sáng': [], 'Chiều': [], 'Tối': []},
      'Chủ nhật': {'Sáng': [], 'Chiều': [], 'Tối': []},
    };

    for (final schedule in list) {
      // Kiểm tra tuần được chọn - so sánh với id_tuan
      if (schedule.idTuan != selectedWeekId.toString()) continue;

      final DateTime ngay =
          DateTime.tryParse(schedule.ngay ?? '') ?? DateTime.now();
      final String thu = _convertWeekdayToVietnamese(ngay.weekday);
      final int tietBatDau = int.parse(schedule.tietBatDau ?? '0');

      print(
        'schedule.idTuan: ${schedule.idTuan}, selectedWeekId: $selectedWeekId',
      );

      // Xác định buổi học dựa trên tiết bắt đầu
      String buoi = 'Sáng';
      if (tietBatDau >= 7 && tietBatDau <= 12) {
        buoi = 'Chiều';
      } else if (tietBatDau > 12) {
        buoi = 'Tối';
      } else {
        buoi = 'Sáng';
      }

      final subject = Subject(
        schedule.lopHocPhan?.tenHocPhan ?? '',
        schedule.lopHocPhan?.lop?.ten ?? '',
        schedule.lopHocPhan?.loaiMon ?? 'Đại cương',
        schedule.phong?.ten ?? '',
        '${schedule.tietBatDau}-${schedule.tietKetThuc}',
      );

      result[thu]?[buoi]?.add(subject);
    }

    return result;
  }

  String _convertWeekdayToVietnamese(int weekday) {
    switch (weekday) {
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  //Xử lý chức năng in tkb
  void _printSchedule(int fromWeek, int toWeek) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('In TKB từ tuần $fromWeek đến tuần $toWeek')),
    );
  }

  void _showPrintDialog() {
    showDialog(
      context: context,
      builder: (_) => PrintScheduleDialog(
        fromWeek: selectedWeek,
        toWeek: selectedWeek,
        onPrint: _printSchedule,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TimeTableBloc>().add(FetchTimeTableEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quản lý Thời Khóa Biểu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (selectedDay != null)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  selectedDay = null;
                });
              },
              tooltip: 'Hiển thị tất cả',
            ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _showPrintDialog(),
            tooltip: 'In thời khóa biểu',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 30, 81, 123),
              const Color.fromARGB(255, 56, 76, 208),
            ],
          ),
        ),
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lọc theo Tuần',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    //LỌC THEO TUẦN CỦA THỜI KHÓA BIỂU SINH VIÊN
                    Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlocBuilder<TimeTableBloc, TimeTableState>(
                            builder: (context, state) {
                              if (state is TimeTableStateLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              }
                              if (state is TimeTableStateLoaded) {
                                final timeTableData = state.timeTables;

                                // Lấy danh sách tuần không trùng lặp từ các schedule
                                // Sử dụng Map để đảm bảo mỗi id chỉ xuất hiện 1 lần
                                final Map<int, dynamic> uniqueWeeksMap = {};

                                for (final schedule in timeTableData) {
                                  if (schedule.tuan != null) {
                                    final tuanId = schedule.tuan!.id;
                                    if (!uniqueWeeksMap.containsKey(tuanId)) {
                                      uniqueWeeksMap[tuanId ?? 0] =
                                          schedule.tuan!;
                                    }
                                  }
                                }

                                // Chuyển đổi thành list và sắp xếp
                                final uniqueWeeks =
                                    uniqueWeeksMap.values.toList()..sort(
                                      (a, b) => int.parse(
                                        a.tuan ?? '0',
                                      ).compareTo(int.parse(b.tuan ?? '0')),
                                    );

                                // Map thành dropdown items với value là id unique
                                final _weeks = uniqueWeeks.map((tuan) {
                                  return DropdownItem(
                                    value: tuan.id.toString(),
                                    label: 'Tuần ${tuan.tuan ?? ''}',
                                    icon: Icons.calendar_today,
                                  );
                                }).toList();

                                // Kiểm tra xem _selectedWeek hiện tại có tồn tại trong danh sách mới không
                                bool selectedWeekExists =
                                    _selectedWeek != null &&
                                    _weeks.any(
                                      (week) =>
                                          week.value == _selectedWeek!.value,
                                    );

                                // Gán tuần mặc định nếu chưa có hoặc không tồn tại trong danh sách mới
                                if (_selectedWeek == null ||
                                    !selectedWeekExists) {
                                  if (_weeks.isNotEmpty) {
                                    _selectedWeek = _weeks.first;
                                    selectedWeek =
                                        int.tryParse(
                                          _selectedWeek?.value ?? '',
                                        ) ??
                                        1;
                                  }
                                }

                                // Giao diện dropdown
                                return DropdownSelector(
                                  label: 'Tuần',
                                  selectedItem: _selectedWeek,
                                  items: _weeks,
                                  onChanged: (item) {
                                    setState(() {
                                      _selectedWeek = item;
                                      selectedWeek =
                                          int.tryParse(item?.value ?? '') ?? 1;
                                    });
                                  },
                                );
                              }
                              if (state is TimeTableStateError) {
                                return Text('Lỗi: ${state.message}');
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            DaySelector(
              selectedDay: selectedDay,
              onDayTap: (String day) {
                setState(() {
                  selectedDay = day;
                });
              },
            ),

            Expanded(
              child: BlocBuilder<TimeTableBloc, TimeTableState>(
                builder: (context, state) {
                  if (state is TimeTableStateLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (state is TimeTableStateLoaded) {
                    final selectedWeekId =
                        int.tryParse(_selectedWeek?.value ?? '') ?? 1;

                    final dynamicData = convertToScheduleData(
                      state.timeTables,
                      selectedWeekId,
                    );

                    return ScheduleView(
                      selectedWeek: selectedWeekId,
                      selectedDay: selectedDay,
                      scheduleData: dynamicData,
                      onDayTap: (String day) {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                    );
                  } else if (state is TimeTableStateError) {
                    return Center(child: Text('Lỗi: ${state.message}'));
                  }
                  return Center(child: Text('Không có dữ liệu'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
