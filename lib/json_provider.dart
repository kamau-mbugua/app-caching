// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:app_cahing_2/row.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApiProvider {
  Future<List<Data>> fetchData() async {
    String fileName = "pathString.json";
    var directory = await getTemporaryDirectory();
    File file = File(directory.path + '/' + fileName);
    if (file.existsSync()) {
      print("Reading from Cached Data");
      print("file path is: $file");
      final body = file.readAsStringSync();
      List cacheResponse = json.decode(body);
      return cacheResponse.map((data) => Data.fromJson(data)).toList();
    } else {
      print("Reading from Live Data");
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        final body = response.body;
        file.writeAsStringSync(body, flush: true, mode: FileMode.writeOnly);
        List jsonResponse = json.decode(body);
        return jsonResponse.map((data) => new Data.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occured!');
      }
    }
  }
}
