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
  Map<String, dynamic> quotes;

  factory ConvertModel.fromJson(Map<String, dynamic> json) => ConvertModel(
        success: json["success"],
        timeframe: json["timeframe"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        source: json["source"],
        quotes: Map.from(json["quotes"])
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "timeframe": timeframe,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "source": source,
        "quotes": Map.from(quotes)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

// class Quote {
//   Quote({
//     required this.result,
//   });
//
//   double result;
//
//   factory Quote.fromJson(Map<String, dynamic> json) => Quote(
//         result: json["USDRUB"].toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "USDRUB": result,
//       };
// }
