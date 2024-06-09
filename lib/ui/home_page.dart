import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitpage_test/model/criteria_model.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CriteriaModel>> futureCriteria;

  @override
  void initState() {
    super.initState();
    futureCriteria = fetchCriteria();
  }

  Future<List<CriteriaModel>> fetchCriteria() async {
    final response = await http.get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => CriteriaModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load criteria');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Stock Criteria',style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: FutureBuilder<List<CriteriaModel>>(
        future: futureCriteria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: snapshot.data![index].color == 'green' ? Colors.green[100] : Colors.red[100],
                    child: ExpansionTile(
                      leading:  Text(snapshot.data![index].name,style: TextStyle(),),
                      title:  Text(snapshot.data![index].tag),
                      trailing: SizedBox.shrink(),
                      expandedAlignment: Alignment.topLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,

                      onExpansionChanged: (val){},
                      children:snapshot.data![index].criteria.map((criteria) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(criteria.text),
                      )).toList(),
                    )
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}