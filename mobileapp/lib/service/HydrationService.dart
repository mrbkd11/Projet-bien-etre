import 'dart:convert';

import 'package:http/http.dart' as http;

class HydrationService {
  final String baseUrl = "http://localhost:8082";

  Future<double> fetchDailyGoal(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users/$userId/daily-goal'));

    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Failed to load daily goal');
    }
  }

  Future<bool> updateDailyGoal(String userId, double newGoal) async {
    final response = await http.post(
      Uri.parse(
          '$baseUrl/waterIntake/updateGoal/$userId'), // Adjusted to match the controller's RequestMapping
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'newGoal': newGoal
      }), // Ensure the body is a JSON object with a key matching the server's expected key
    );

    if (response.statusCode == 200) {
      // Handle successful request
      print("Goal updated successfully.");
      return true;
    } else {
      // Handle error response
      print(
          "Failed to update goal. Status code: ${response.statusCode}. Response body: ${response.body}");
      return false;
    }
  }

  Future<double> fetchCurrentIntake(String userId) async {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}"; // Format date as YYYY-MM-DD

    final response = await http.get(
      Uri.parse('$baseUrl/waterIntake/daily/$userId?date=$formattedDate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Assuming the response body directly contains the intake amount as a double
      final responseData = json.decode(response.body);
      return double.parse(response.body);
      // Adjust based on how your actual response is structured
    } else {
      throw Exception('Failed to load current intake');
    }
  }

  Future<bool> logWaterIntake(String userId, double amount) async {
    final url = Uri.parse('$baseUrl/waterIntake/logIntake');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': userId,
          'amount': amount,
          // You might need to format the date to match your backend expectation
        }));

    return response.statusCode == 200;
  }
}
