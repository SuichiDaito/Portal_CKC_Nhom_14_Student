class ListTrainingPoints {
  List<TrainingPointModel> listPoint;

  ListTrainingPoints({required this.listPoint});

  factory ListTrainingPoints.fromJson(Map<String, dynamic> json) {
    return ListTrainingPoints(
      listPoint: (json['data'] as List<dynamic>)
          .map((item) => TrainingPointModel.fromJson(item))
          .toList(),
    );
  }
}

class TrainingPointModel {
  final int id;
  final int idStudent;
  final int totalYear;
  final String typePoint;
  final int month;
  final Years years;

  TrainingPointModel({
    required this.id,
    required this.idStudent,
    required this.totalYear,
    required this.typePoint,
    required this.month,
    required this.years,
  });

  factory TrainingPointModel.fromJson(Map<String, dynamic> json) {
    return TrainingPointModel(
      id: json['id'],
      idStudent: json['id_sinh_vien'],
      totalYear: json['id_nam'],
      typePoint: json['xep_loai'],
      month: json['thoi_gian'],
      years: Years.fromJson(json['nam_hoc']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_sinh_vien': idStudent,
      'id_nam': totalYear,
      'xep_loai': typePoint,
      'thoi_gian': month,
      'nam_hoc': years.toJson(),
    };
  }
}

class Years {
  final int id;
  final int startYear;

  Years({required this.id, required this.startYear});

  factory Years.fromJson(Map<String, dynamic> json) {
    return Years(id: json['id'], startYear: json['nam_bat_dau']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nam_bat_dau': startYear};
  }
}
