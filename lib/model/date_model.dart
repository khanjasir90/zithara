class DateModel {

  DateModel({
    required this.id,
    required this.dateType,
    required this.enabled,
  });

  String id;
  String dateType;
  bool enabled;


  static List<DateModel> getDateModelList() {
    return [
      DateModel(id: '1', dateType: 'dd-mm-yyyy', enabled: true),
      DateModel(id: '2', dateType: 'mm-dd-yyyy', enabled: false),
      DateModel(id: '3', dateType: 'yyyy-mm-dd', enabled: false),
      DateModel(id: '4', dateType: 'yyyy-dd-mm', enabled: false),
      DateModel(id: '5', dateType: 'dd/mm/yyyy', enabled: false),
      DateModel(id: '6', dateType: 'mm/dd/yyyy', enabled: false),
      DateModel(id: '7', dateType: 'yyyy/mm/dd', enabled: false),
      DateModel(id: '8', dateType: 'yyyy/dd/mm', enabled: false),
    ];
  }

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
    id: json["id"],
    dateType: json["date_type"],
    enabled: json["enabled"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_type": dateType,
    "enabled": enabled,
  };
}