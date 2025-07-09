class GraphStasticsModel {
  String? date;
  dynamic value;

  GraphStasticsModel({this.date, this.value});

  factory GraphStasticsModel.fromJson(Map<String, dynamic> json) =>
      GraphStasticsModel(
        date: json['date'] as String?,
        value: json['value'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'value': value,
      };
}
