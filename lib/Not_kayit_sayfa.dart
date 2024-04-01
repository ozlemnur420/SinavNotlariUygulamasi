import 'package:flutter/material.dart';
import 'package:sinav_notlari_uygulamasi/Notlardao.dart';
import 'package:sinav_notlari_uygulamasi/main.dart';

class Not_kayit_sayfa extends StatefulWidget {
  const Not_kayit_sayfa({super.key});

  @override
  State<Not_kayit_sayfa> createState() => _Not_kayit_sayfaState();
}

class _Not_kayit_sayfaState extends State<Not_kayit_sayfa> {

  var tf_ders_adi=TextEditingController();
  var tf_not1=TextEditingController();
  var tf_not2=TextEditingController();

  Future<void> kayit(String ders_adi,int not1,int not2) async{
    await Notlardao().not_ekle(ders_adi, not1, not2);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa(title: "title")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("NOT KAYIT",style: TextStyle(color: Colors.indigo,fontSize: 16),),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          kayit(tf_ders_adi.text, int.parse(tf_not1.text), int.parse(tf_not2.text));
        },
        tooltip: 'Not kayıt',
        icon: const Icon(Icons.save_as),
        label: Text("Kaydet"),
      ),
    );
  }
}
