import 'package:easy_localization/easy_localization.dart';

class ConvertModel {
  ConvertModel({
    required this.success,
    required this.timeframe,
    required this.startDate,
    required this.endDate,
    required this.source,
    required this.quotes,
  });

  bool success;
  bool timeframe;
  DateTime startDate;
  DateTime endDate;
  String source;
  Map<String, Quote> quotes;

  factory ConvertModel.fromJson(Map<String, dynamic> json) => ConvertModel(
        success: json["success"],
        timeframe: json["timeframe"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        source: json["source"],
        quotes: Map.from(json["quotes"]).map((k, v) => MapEntry<String, Quote>(
            DateFormat("yyyy-MM-dd").format(DateTime.parse(k)),
            Quote.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "timeframe": timeframe,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "source": source,
      };
}

class Quote {
  Quote({
    required this.result,
  });

  double result;

  factory Quote.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;
    return Quote(
      result: json[key]!.toDouble(),
    );
  }
}
