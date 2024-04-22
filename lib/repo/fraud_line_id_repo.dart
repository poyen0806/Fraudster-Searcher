import 'package:dio/dio.dart';
import 'package:pre_assessment/model/fraud_line_id.dart';

/// Repository class responsible for fetching fraud line id data from an API.
class FraudLineIdRepo {
  Dio dio = Dio();

  /// Fetches fraud line id data from the API.
  ///
  /// Returns a list of maps containing fraud line id data.
  Future<List<Map<String, dynamic>>> getFrauds() async {
    // API URL
    String apiUrl =
        "https://od.moi.gov.tw/api/v1/rest/datastore/A01010000C-001277-053";
    // Get API data
    Response response = await dio.get(apiUrl);
    // List to store the fraud line id data
    List<Map<String, dynamic>> fraudLineIdList = [];

    // Check the response status code
    // Status code reference: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
    if (response.statusCode == 200) {
      for (var fraudLineId in response.data["result"]["records"]) {
        fraudLineIdList.add(FraudLineId.fromJson(fraudLineId).toJson());
      }
    } else {
      throw Exception("failed to get api data");
    }

    return fraudLineIdList;
  }
}
