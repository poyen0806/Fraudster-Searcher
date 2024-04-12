import 'package:dio/dio.dart';
import 'package:pre_assessment/model/fraud_line_id.dart';

class FraudLineIdRepo {
  Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getFraudLineIdList() async {
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
