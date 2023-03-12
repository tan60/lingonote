import 'package:intl/intl.dart';
import 'package:lingonote/datas/models/achieve_model.dart';
import 'package:lingonote/datas/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static final DataBaseHelper _singleton = DataBaseHelper._internal();

  DataBaseHelper._internal();

  factory DataBaseHelper() {
    return _singleton;
  }

  Future<Database> openDB() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'lingonote.db'),
      version: 1,
      onCreate: (db, version) {
        _onCreate(db, version);
      },
      onConfigure: (db) {},
      onUpgrade: (db, oldVersion, newVersion) {},
    );
    return database;
  }

  /* Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE IF NOT EXISTS post (
              post_no INTEGER PRIMARY KEY,
              post_topic TEXT NOT NULL,
              post_contents TEXT NOT NULL,
              post_improved TEXT NOT NULL,
              post_issue_date_time TEXT NOT NULL,
              post_fixed_date_time TEXT NOT NULL,
              post_improved_type TEXT NOT NULL,
              FOREIGN KEY (user_uid) REFERENCES user (user_uid) 
                        ON DELETE NO ACTION ON UPDATE NO ACTION
            )
          ''');
  } */

  Future _onCreate(Database db, int version) async {
    await db.execute('''
            CREATE TABLE IF NOT EXISTS post (
              post_no INTEGER PRIMARY KEY,
              post_topic TEXT NOT NULL,
              post_contents TEXT NOT NULL,
              post_improved TEXT NOT NULL,
              post_issue_date TEXT NOT NULL,
              post_issue_date_time TEXT NOT NULL,
              post_fixed_date_time TEXT NOT NULL,
              post_improved_type TEXT NOT NULL,
              user_uid type INTEGER

            )
          ''');
  }

  Future addNote(NoteModel note) async {
    final db = await openDB();

    note.postNo = await db.insert(
      'post',
      {
        'post_topic': note.topic,
        'post_contents': note.contents,
        'post_improved': note.improved,
        'post_issue_date': note.issueDate,
        'post_issue_date_time': note.issueDateTime, //'2022-01-01 00:00:00',
        'post_fixed_date_time': note.issueDateTime,
        'post_improved_type': note.improvedType,
        'user_uid': note.userUid
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return note;
  }

  Future updateNote(NoteModel note) async {
    final db = await openDB();
    await db.update(
      'post', // table name
      {
        'post_topic': note.topic,
        'post_contents': note.contents,
        'post_improved': note.improved,
        'post_fixed_date_time': note.fixedDateTime, //'2022-01-01 00:00:00',
        'post_improved_type': note.improvedType,
      },
      where: 'post_no = ?',
      whereArgs: [note.postNo],
    );
    return note;
  }

  Future<List<NoteModel>> getNotes(int userUid) async {
    final db = await openDB();
    List<Map<String, dynamic>> maps = await db.query('post',
        where: 'user_uid = ?', whereArgs: [userUid], orderBy: 'post_no DESC');

    return List.generate(maps.length, (i) {
      return NoteModel(
        topic: maps[i]['post_topic'],
        contents: maps[i]['post_contents'],
        improved: maps[i]['post_improved'],
        improvedType: maps[i]['post_improved_type'],
        issueDate: maps[i]['post_issue_date'],
        issueDateTime: maps[i]['post_issue_date_time'],
        fixedDateTime: maps[i]['post_fixed_date_time'],
        userUid: maps[i]['user_uid'],
      );
    });
  }

  Future<int> getTotalCountNotes() async {
    final db = await openDB();
    var x = await db.rawQuery('select count(*) from post');
    int totalCount = Sqflite.firstIntValue(x)!;
    return totalCount;
  }

  Future<NoteModel>? getFristNote(int userUid) async {
    final db = await openDB();
    List<Map<String, dynamic>> maps = await db.query('post',
        where: 'user_uid = ?',
        whereArgs: [userUid],
        orderBy: 'post_no ASC',
        limit: 1);

    return List.generate(maps.length, (i) {
      return NoteModel(
        topic: maps[i]['post_topic'],
        contents: maps[i]['post_contents'],
        improved: maps[i]['post_improved'],
        improvedType: maps[i]['post_improved_type'],
        issueDate: maps[i]['post_issue_date'],
        issueDateTime: maps[i]['post_issue_date_time'],
        fixedDateTime: maps[i]['post_fixed_date_time'],
        userUid: maps[i]['user_uid'],
      );
    })[0];
  }

  Future<List<AchieveModel>>? getArchive(int userUid) async {
    final db = await openDB();
    final format = DateFormat('yyyy-MM-dd');

    List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT date(post_issue_date) AS date, COUNT(*) AS count 
          FROM post GROUP BY date(post_issue_date)
        ''');

    return List.generate(maps.length, (i) {
      return AchieveModel(
        date: maps[i]['date'] as String,
        postedCount: maps[i]['count'] as int,
      );
    });
  }
}
