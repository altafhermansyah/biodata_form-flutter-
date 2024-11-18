import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_project/models/api.dart';
import 'package:http/http.dart' as http;

import '../models/mitems.dart';
import 'form.dart';

class ProdukEdit extends StatefulWidget{
  final ItemModel sw;

  ProdukEdit({required this.sw});
  @override
  State<StatefulWidget> createState() => ProdukEditState();
}

class ProdukEditState extends State<ProdukEdit>{
  final formkey = GlobalKey<FormState>();

  late TextEditingController kodeController, namaController, hargaController;

  Future editSw() async {
    return await http.post(
        Uri.parse(BaseUrl.edit),
        body: {
          "id": widget.sw.id.toString(),
          "kode": kodeController.text,
          "nama": namaController.text,
          "harga": hargaController.text,
        }
    );
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if(data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override

  void initState() {
    kodeController = TextEditingController(text: widget.sw.kode);
    namaController = TextEditingController(text: widget.sw.nama);
    hargaController = TextEditingController(text: widget.sw.harga.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Barang",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            child: Text("Update"),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.cyan,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
            ),
            onPressed: () {
              _onConfirm(context);
            },
          )
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: AppForm(
            formkey: formkey,
            kodeController: kodeController,
            namaController: namaController,
            hargaController: hargaController
          ),
        ),
      ),
    );
  }
  
}