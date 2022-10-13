import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/model.dart';
import '../main.dart';
import 'component.dart';
import 'dart:ui' as ui;

  late final Future<Database> database;
  Future<void> createDatabase() async
  {
      database = openDatabase(
      join(await getDatabasesPath() ,
          'clinic_db01.db'),
      onCreate: (db , version)
      {
        return db.execute("CREATE TABLE clinic (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , name TEXT NOT NULL ,phone TEXT NOT NULL,age TEXT NOT NULL,problem TEXT NOT NULL"
            ",date TEXT NOT NULL,type TEXT NOT NULL,money TEXT NOT NULL,"
            "rest TEXT NOT NULL,notes TEXT NOT NULL ) "
        ).then((value){
          print("Database Created");

          var person = Clinic(id: 0,name: "name",age: "age",problem: "problem", date: "date", phone: 'phone', type: 'type', money: 'money', rest: 'rest money', notes: 'notes');
          initDor(person);
        });

      },
      version: 1,
    );

  }
  Future<void> initDor(Clinic c)async
  {
  final Database db = await database;
  await db.insert('clinic', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

  Future<void> insertDor(Clinic c ,  BuildContext context)async
  {
    final Database db = await database;
    await db.insert('clinic', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace
    ).then((value) {
      showToast(
      context: context,
      color: Colors.green,
      msg: "تم حجز كشف بنجاح"
      )
      ;}
    ).catchError((e){
      showToast(
          context: context,
          color: Colors.red,
          msg: "فشل حجز هذا الكشف "
      );
    });
  }

  Future<List<Clinic>> allDorWithIndexZero() async
  {
    final Database db =await database;
    final List<Map<String , dynamic>> map = await db.query('clinic' ,
    );
    return List.generate(map.length,
            (index)
        {
          return Clinic(
            id: map[index]['id'],
            name: map[index]['name'],
            phone: map[index]['phone'],
            age: map[index]['age'],
            problem: map[index]['problem'],
            date: map[index]['date'],
            type: map[index]['type'],
            money: map[index]['money'],
            rest: map[index]['rest'],
            notes: map[index]['notes'],
          );
        }
    );
  }
  Future<List<Clinic>> dorId(int id ) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id = ? " , whereArgs: [id]
  );
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}
  Future<List<Clinic>> allDor() async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id != ? " , whereArgs: [0]
  );
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}
  Future<List<Clinic>> allDorWithID(int id) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id = ? " , whereArgs: [id]
  );
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}

  Future<List<Clinic>> allDorWithDate(String date) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id != ? and date = ?" , whereArgs: [0,date]
  );
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}
  Future<List<Clinic>> allDorWithLast50Date() async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.rawQuery('select * from clinic ORDER BY id DESC LIMIT 100 ');
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}
  Future<int> allDorCount(String date) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id != ? and date = ?" , whereArgs: [0,date]
  );
  return map.length;
}
  Future<void> updateDor(Clinic c , BuildContext context)async
  {
  final db = await database ;
  await db.update('clinic', c.toMap() , where: "id = ? " , whereArgs: [c.id]
  ).then((value) {
    showToast(
      context: context,
      msg: "تم تعديل الكشف بنجاح",
      color: Colors.green,
    );
  }
  ).catchError((e){
    showToast(
      context: context,
      msg: "فشل تعديل هذا الكشف ",
      color: Colors.red,
    );
  });
}
  Future<int> maxID() async
  {
  var id;
  final Database db =await database;
  id = Sqflite.firstIntValue(await db.rawQuery('SELECT max(id) FROM clinic'));
  return id;
}
  Future<void> deleteDor(int id ,BuildContext context)async
  {
  final db = await database ;
  await db.delete('clinic', where: "id = ? " , whereArgs: [id]
  ).then((value) {
    showToast(
      context: context,
      color: Colors.green,
      msg: "تم حذف الكشف بنجاح"
    );
  }).catchError((error)
  {
    showToast(
        context: context,
        color: Colors.red,
        msg: "فشل حذف هذا الكشف "
    );
  });
}
  Future<bool> checkDor(String date ) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "date = ? " , whereArgs: [date]
  );
  return map.isNotEmpty ?true : false;
}
  Future<bool> checkName(String name ) async
  {
    final Database db =await database;
    final List<Map<String , dynamic>> map = await
    db.rawQuery("SELECT * FROM clinic WHERE name LIKE '%$name%'"
    );
  return map.isNotEmpty ?true : false;
}
  Future<void> updateDate({required String date ,required int id ,required BuildContext context
  })async
  {
  final db = await database ;
  await db.rawUpdate('UPDATE clinic SET date = ? , type = ? WHERE id = ?', [date,"إعادة", id]).
  then((value) {
    showToast(
        context: context,
        color: Colors.green,
        msg: "تم حجز إعادة بنجاح"
    );
  }
  ).catchError((e){
    showToast(
        context: context,
        color: Colors.red,
        msg: "فشل حجز إعادة "
    );
  });
}
  Future<List<Clinic>> allClinicSearch(String name) async
  {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await
  db.rawQuery("SELECT * FROM clinic WHERE name LIKE '%$name%'"
  );
  return List.generate(map.length,
          (index)
      {
        return Clinic(
          id: map[index]['id'],
          name: map[index]['name'],
          phone: map[index]['phone'],
          age: map[index]['age'],
          problem: map[index]['problem'],
          date: map[index]['date'],
          type: map[index]['type'],
          money: map[index]['money'],
          rest: map[index]['rest'],
          notes: map[index]['notes'],
        );
      }
  );
}
//----------------------------------------------------------








Future<List<Map<String, Object?>>> allPassengerName() async {
  final Database db =await database;
   var map = await db.rawQuery('SELECT name FROM clinic WHERE id !=?', [0]);

  return map;
}




Future<bool> allDorYesOrNo() async {
  final Database db =await database;
  final List<Map<String , dynamic>> map = await db.query('clinic' ,
      where: "id !=0 " ,
  );
  return map.isNotEmpty ?true : false;
}





/*
Future<void> updateImage(
{
  required String photo ,required int id ,required BuildContext context
})async
{
  final db = await database ;
  await db.rawUpdate('UPDATE clinic SET picture = ? WHERE id = ?', [photo, id]).
  then((value) {showToastUpdateImage(context);}
  ).catchError((e){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(

      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('فشل تعديل صورة هذا المسافر' , style: TextStyle(color: Colors.red,fontSize: 18),textAlign: TextAlign.right,),
      ),
    );
  });
}
*/







// use it

/*
// 1.
var math = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await insertCousre(math);


// 2.
var math2 = Course(id: 1, name: 'alaa', teacher: 'father', day: 'sunday', hour: 1, phone: '01012');
await UpdateCourse(math);
// 3.
await DeleteCourse(math.id);

// 4.
print(await course());


*/