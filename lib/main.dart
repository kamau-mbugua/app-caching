// @dart=2.9
import 'package:app_cahing_2/json_provider.dart';
import 'package:app_cahing_2/row.dart';
import 'package:flutter/material.dart';

/*Future<List<Data>> fetchData() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  // String fileName = "pathString.json";
  // var dir = await getTemporaryDirectory();

  // File file =File(dir.path+'/'+ fileName);

  // if(file.existsSync()){
  //   print("Reading cached Data");
  //   // List dataCahed = file.readAsString();
  //   // final response = json.decode(dataCahed);
  //   List jseonCachedData = json.decode();

  // }

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}*/

// class Data {
//   final int postId;
//   final int id;
//   final String name;
//   final String email;
//   final String body;

//   Data({this.postId, this.id, this.name, this.email, this.body});

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       postId: json['postId'],
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       body: json['body'],
//     );
//   }
// }

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ApiProvider().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Caching The App"), backgroundColor: Colors.blue),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data> data = snapshot.data;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: const FlutterLogo(size: 56.0),
                          title: Text(data[index].email),
                          subtitle: Text(data[index].body),
                          trailing: const Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                print("Error found is: ${snapshot.error}");
                return Text("Error found is:  ${snapshot.error}");
              }
              // By default show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
