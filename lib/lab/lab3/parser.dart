import 'package:http/http.dart' as http;
import 'parse_currency.dart';

class Parser {
  static Future<Currency> getUsers() async {
    var url = Uri.parse('https://www.cbr-xml-daily.ru/daily_json.js');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Currency currency = currencyFromJson(response.body);
        return currency;
      } else {
        return Currency();
      }
    } catch (e) {
      return Currency();
    }
  }
}
