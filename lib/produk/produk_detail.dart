import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:second_project/models/api.dart';
import 'package:second_project/produk/produk_edit.dart';

import '../models/mitems.dart';

class ProdukDetail extends StatefulWidget{
  final ItemModel sw;
  ProdukDetail({required this.sw});
  @override
  State<StatefulWidget> createState() => ProdukDetailState();
}

class ProdukDetailState extends State<ProdukDetail>{
  void deleteSiswa(context) async {
    http.Response response = await http.post(
        Uri.parse(BaseUrl.hapus),
        body: {
          'id' : widget.sw.id.toString(),
        }
    );
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Penghapusan Data Berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Anda yakin menghapus data ini?'),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel)
            ),
            ElevatedButton(
                onPressed: () => deleteSiswa(context),
                child: Icon(Icons.check_circle)
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Barang",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        actions: [
          IconButton(onPressed: () => confirmDelete(context), icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Id: ${widget.sw.id}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.tag, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Kode: ${widget.sw.kode}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.adb, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Nama: ${widget.sw.nama}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Icon(Icons.monetization_on, size: 28, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Harga: ${widget.sw.harga}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.green,
        onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => ProdukEdit(sw: widget.sw))
            ),
        child: Icon(Icons.edit, color: Colors.white,),
      ),
    );
  }
  
}