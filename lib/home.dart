import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'name.db');
    Database mydb = await openDatabase(path, onCreate: _oncreat, version: 1);
    return mydb;
  }

  _oncreat(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE notes (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    note TEXT ) ''');
    print("111111"); // copy to new table
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
}

class _HomeState extends State<Home> {
  sqldb sqlDp = sqldb();

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [

            Container(height: 600,
              color: Colors.orangeAccent.shade100,
              child: ListView(
                children: [

                ],
              ),
            ),
            Column(
              children: [ SizedBox(height: 16),
              Container(height: 300,width: 300,decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
               color: Colors.green

              ),),
                Container(child: Text("Fayez Habib",style: TextStyle(fontSize: 45
                ,fontWeight: FontWeight.bold),),),
                Container(child: Text("Sound & Lighting System",style: TextStyle(fontSize: 20
                    ,fontWeight: FontWeight.w500),),),
                SizedBox(height: 20,),
                Container( height: 200,width: 400,
                  decoration: BoxDecoration(
                          color:Colors.green

                ),)
              ],
            )

          ],
        ));
  }
}
