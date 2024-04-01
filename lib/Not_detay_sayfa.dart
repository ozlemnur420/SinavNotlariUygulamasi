import 'package:flutter/material.dart';
import 'package:sinav_notlari_uygulamasi/Notlar.dart';
import 'package:sinav_notlari_uygulamasi/Notlardao.dart';
import 'package:sinav_notlari_uygulamasi/main.dart';

class Not_detay_sayfa extends StatefulWidget {

  Notlar not;

  Not_detay_sayfa({required this.not});

  @override
  State<Not_detay_sayfa> createState() => _Not_detay_sayfaState();
}

class _Not_detay_sayfaState extends State<Not_detay_sayfa> {

  var tf_ders_adi=TextEditingController();
  var tf_not1=TextEditingController();
  var tf_not2=TextEditingController();

  Future<void>sil(int not_id) async{
    await Notlardao().not_sil(not_id);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa(title: '',)));
  }

  Future<void>guncelle(int not_id,String ders_adi,int not1,int not2) async{
    await Notlardao().not_guncelle(not_id, ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa(title: '',)));
  }

  @override
  void initState() {
    super.initState();
    var not=widget.not;
    tf_ders_adi.text=not.ders_adi;
    tf_not1.text=not.not1.toString();
    tf_not2.text=not.not2.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("NOT DETAY",style: TextStyle(color: Colors.indigo,fontSize: 16)),
        actions: [

          TextButton(
            child: Text("SİL",style: TextStyle(color: Colors.teal),),
            onPressed: (){
              sil(widget.not.not_id);
            },

          ),

          TextButton(
            child: Text("GÜNCELLE",style: TextStyle(color: Colors.teal),),
            onPressed: (){
            guncelle(widget.not.not_id, tf_ders_adi.text,int.parse(tf_not1.text),int.parse(tf_not2.text));
            },

          )

        ],
      ),

      body: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: tf_ders_adi,
                      decoration: InputDecoration(hintText: "Ders adı"),
                    ),

                    TextField(
                      controller: tf_not1,
                      decoration: InputDecoration(hintText: "Birinci not"),
                    ),

                    TextField(
                      controller: tf_not2,
                      decoration: InputDecoration(hintText: "İkinci not"),
                    ),

                  ],
                ),
              ),
            ),
    );
  }
}
