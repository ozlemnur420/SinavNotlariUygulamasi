import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sinav_notlari_uygulamasi/Not_detay_sayfa.dart';
import 'package:sinav_notlari_uygulamasi/Not_kayit_sayfa.dart';
import 'package:sinav_notlari_uygulamasi/Notlar.dart';
import 'package:sinav_notlari_uygulamasi/Notlardao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: Anasayfa(title: '',),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key, required this.title});

  final String title;

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  Future<List<Notlar>>tum_notlari_goster() async{

    var notlar_listesi= await Notlardao().tum_notlar();
    return notlar_listesi;

  }


  Future<bool>uygulamayi_kapat() async{

    await exit(0);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: (){
            uygulamayi_kapat();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

           Text("NOTLAR UYGULAMASI",style: TextStyle(color: Colors.indigo,fontSize: 16),),
            FutureBuilder<List<Notlar>>(
              future: tum_notlari_goster(),
                builder: (context,snapshot){
                if(snapshot.hasData) {
                  var notlar_listesi = snapshot.data;

                  double ortalama=0.0;

                  if(!notlar_listesi !.isEmpty){
                    double toplam=0.0;
                    for(var n in notlar_listesi){
                      toplam=toplam+(n.not1+n.not2)/2;
                    }
                    ortalama=toplam/notlar_listesi.length;
                  }
                  return Text("Ortalama: ${ortalama.toInt()} ",style: TextStyle(color: Colors.indigo,fontSize: 14),);

                }
                else{
                  return Text("Ortalama: 0 ",style: TextStyle(color: Colors.indigo,fontSize: 14),);
                }

                },
            ),
         ],

        ),
      ),
      body: WillPopScope(
        onWillPop: uygulamayi_kapat,
        child: FutureBuilder<List<Notlar>>(

          future: tum_notlari_goster(),
           builder: (context,snapshot){

            if(snapshot.hasData){

              var notlar_listesi=snapshot.data;
              return ListView.builder(
                itemCount: notlar_listesi!.length,
                itemBuilder: (context,indeks){
                  var not=notlar_listesi[indeks];
                  return GestureDetector(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Not_detay_sayfa(not: not,)));
                    },
                    child: Card(
                      child:SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(not.ders_adi,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(not.not1.toString()),
                            Text(not.not2.toString()),
                          ],

                        ),
                      ),


                    ),
                  );

                },
              );
            }

            else{
              return Center();
            }

           },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Not_kayit_sayfa()));
        },
        tooltip: 'Not ekle',
        child: const Icon(Icons.add),
      ),
    );
  }
}
