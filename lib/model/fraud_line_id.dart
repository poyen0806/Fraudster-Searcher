import 'package:intl/intl.dart';

class FraudLineId {
  String fraudId;
  DateTime reportDate;

  FraudLineId({
    required this.fraudId,
    required this.reportDate,
  });

  factory FraudLineId.fromJson(Map<String, dynamic> json) {
    return FraudLineId(
      fraudId: json["帳號"] as String,
      reportDate: DateFormat("yyyy/MM/dd").parse(json["通報日期"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "帳號": fraudId,
      "通報日期": DateFormat("yyyy/MM/dd").format(reportDate),
    };
  }
}
