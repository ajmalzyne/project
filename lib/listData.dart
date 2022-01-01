import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({Key? key}) : super(key: key);

  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  Map? dataCollection;
  List? dataList;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/products'));
    if (response.statusCode == 200) {
      setState(() {
        dataCollection = json.decode(response.body);
        dataList = dataCollection!['data'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'List Data',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: dataList == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xff2fc5ba),
                  Color(0xff8FC2D8),
                  Color(0xffB4C9F5).withOpacity(0.3),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                child: ListView.builder(
                    itemCount: dataList == null ? 0 : dataList?.length,
                    itemBuilder: (BuildContext context, index) {
                      // return Center(
                      //   child: Container(
                      //     height: 100,
                      //     width: 100,
                      //     color: Color(hexColor('${dataList![index]['color']}')),
                      //     child: Text('${dataList![index]['name'].toString()}'),
                      //   ),
                      // );
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 30, left: 30, bottom: 30),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.110,
                          child: Card(
                            color:
                                Color(hexColor('${dataList![index]['color']}')),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name : ${dataList![index]['name']}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Year : ${dataList![index]['year']}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}
