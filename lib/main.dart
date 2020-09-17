import 'package:api/RpEvent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




Future<RpEvent> fetchEvent() async {
  final response =
  await http.get('https://basis.org.bd/api/events-awards/events');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RpEvent.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<RpEvent> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("All Events"),
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          backgroundColor: Colors.cyan,
        ),
        body: Center(
          child: FutureBuilder<RpEvent>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Scaffold(

                  body: ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext, index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Image.network(
                                  "https://basis.org.bd/public/"+snapshot.data.data[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(snapshot.data.data[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                    ),
                                    SizedBox(width: 5),
                                    Text("will be update later",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text("will be update later",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}
