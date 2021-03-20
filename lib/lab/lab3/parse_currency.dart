// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  Currency({
    this.date,
    this.previousDate,
    this.previousUrl,
    this.timestamp,
    this.valute,
  });

  DateTime date;
  DateTime previousDate;
  String previousUrl;
  DateTime timestamp;
  Map<String, Valute> valute;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        date: DateTime.parse(json["Date"]),
        previousDate: DateTime.parse(json["PreviousDate"]),
        previousUrl: json["PreviousURL"],
        timestamp: DateTime.parse(json["Timestamp"]),
        valute: Map.from(json["Valute"])
            .map((k, v) => MapEntry<String, Valute>(k, Valute.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "Date": date.toIso8601String(),
        "PreviousDate": previousDate.toIso8601String(),
        "PreviousURL": previousUrl,
        "Timestamp": timestamp.toIso8601String(),
        "Valute": Map.from(valute)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Valute {
  Valute({
    this.id,
    this.numCode,
    this.charCode,
    this.nominal,
    this.name,
    this.value,
    this.previous,
  });

  String id;
  String numCode;
  String charCode;
  int nominal;
  String name;
  double value;
  double previous;

  factory Valute.fromJson(Map<String, dynamic> json) => Valute(
        id: json["ID"],
        numCode: json["NumCode"],
        charCode: json["CharCode"],
        nominal: json["Nominal"],
        name: json["Name"],
        value: json["Value"].toDouble(),
        previous: json["Previous"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NumCode": numCode,
        "CharCode": charCode,
        "Nominal": nominal,
        "Name": name,
        "Value": value,
        "Previous": previous,
      };
}
