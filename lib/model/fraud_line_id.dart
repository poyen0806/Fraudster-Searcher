import 'package:intl/intl.dart';

/// Represents a fraud line identification with its ID and report date.
class FraudLineId {
  // The LINE ID of the fraud
  String fraudId;
  // The date when the fraud was reported
  DateTime reportDate;

  FraudLineId({
    required this.fraudId,
    required this.reportDate,
  });

  /// Factory method to create a [FraudLineId] instance from a JSON map.
  ///
  /// [json] is the map containing the fraud ID and report date.
  /// Returns a [FraudLineId] instance.
  factory FraudLineId.fromJson(Map<String, dynamic> json) {
    return FraudLineId(
      fraudId: json["帳號"] as String,
      reportDate: DateFormat("yyyy/MM/dd").parse(json["通報日期"] as String),
    );
  }

  /// Converts the [FraudLineId] instance to a JSON map.
  ///
  /// Returns a map containing the fraud ID and report date.
  Map<String, dynamic> toJson() {
    return {
      "帳號": fraudId,
      "通報日期": DateFormat("yyyy/MM/dd").format(reportDate),
    };
  }
}
