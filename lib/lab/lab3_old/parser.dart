// import 'package:http/http.dart' as http;
// import 'parse_currency.dart';

// class Parser {
//   Future<Currency> getUsers() async {
//     var url = Uri.parse('cbr-xml-daily.ru/daily_json.js');

//     try {
//       final response = await http.get(url);
//       print('------------');
//       print(response.body);
//       print('------------');
//       if (response.statusCode == 200) {
//         final Currency currency = currencyFromJson(response.body);
//         return currency;
//       } else {
//         return Currency();
//       }
//     } catch (e) {
//       return Currency();
//     }
//   }
// }
