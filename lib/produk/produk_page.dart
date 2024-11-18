import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/produk/produk_detail.dart';
import 'package:second_project/produk/produk_tambah.dart';
import 'package:second_project/models/api.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import '../models/mitems.dart';

class ProdukPage extends StatefulWidget{
  @override
  ProdukPage({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return ProdukPageState();
  }

}
class ProdukPageState extends State<ProdukPage>{
  late Future<List<ItemModel>> sw;


  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ItemModel>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ItemModel> sw = items.map<ItemModel>((json) {
      return ItemModel.fromJson(json);
    }).toList();
    return sw;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Data Barang",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0, // Adds shadow to the AppBar
      ),
      body: Container(
        color: Colors.grey[200], // Light background color
        child: FutureBuilder<List<ItemModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot<List<ItemModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Show error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found')); // Handle empty data
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]), // Adds dividers
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  elevation: 5, // Adds shadow to the card
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.adb, color: Colors.white),
                    ),
                    title: Text(
                      data.nama,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Rp. ${data.harga.toString() ?? '0'}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukDetail(sw: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        hoverColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukTambah()));
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

}