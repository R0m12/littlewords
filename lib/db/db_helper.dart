import 'dart:async';
import 'package:littlewords/dto/word_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///Classe permettant de gérer la base de données.
class DbHelper{
  static const dbName = 'littlewords.db';
  static const dbPathName = 'littlewords.path';
  static const dbVersion = 1;
  static const tableName = 'Words';

  //Instance de connexion à la db
  static Database? _database;

  //Definition d'un constructeur privé
  //DbHelper._privateConstructor();

  //Création variable instance permettant d'obtenir un acces au singleton
  //static final DbHelper instance = DbHelper._privateConstructor();

  //Getter de database avec init si necessaire
 // Future<Database> get database async => _database ??= await _init();

  //Initialisation de database
 static init() async{
    final String dbPath = await getDatabasesPath();
    final String path = dbPath + dbName;

    //On ouvre la connexion
    final Database maDatabase = await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: dbVersion,
    );
    _database = maDatabase;
  }

  ///Déclenché lorsque la base de données n'existe pas sur le device
  static _onCreate(Database db, int version){
    const String createWordsTableQuery = '''CREATE TABLE IF NOT EXISTS $tableName (
        uid INTEGER PRIMARY KEY NOT NULL,
        author VARCHAR NOT NULL,
        content VARCHAR NOT NULL,
        latitude REAL NULL,
        longitude REAL NULL
    )''';
    db.execute(createWordsTableQuery);
  }

  ///Déclenché lorsque le numéro de version est augmenté
  static _onUpgrade(Database db, int oldVersion, int newVersion){
    const String dropWordsTableQuery = 'DROP TABLE IF EXISTS $tableName';
    db.execute(dropWordsTableQuery);
  }

  /// Insertion d'un mot dans la base de données
  static void insert(WordDTO wordDTO) {
    final Map<String, dynamic> mapDesMots = wordDTO.toJson();
    _database!.insert(tableName, mapDesMots);
  }

  /// Suppression d'un mot dans la base de données
  //static Future<void> delete(WordDTO wordDTO) async {
  static Future<void> delete(String uidWord) async {
    //final String deleteWord = "DELETE FROM $tableName WHERE uid = ${uidWord}";
    //_database!.delete(deleteWord);
    await _database!.delete(tableName, where: 'uid = ?', whereArgs: [uidWord]);
  }

  /// Récupération de tous les mots de la base de données
  static Future<List<WordDTO>> getAllWords() async {
    final List<Map<String, Object?>> resultSet = await _database!.query(tableName);
    List<WordDTO> listeDeMesMots = List.generate(resultSet.length, (index) {
      return WordDTO.fromJson(resultSet[index]);
    });

    if(listeDeMesMots.isEmpty){
      return [];
    }

    // Convertir chaque ligne de resultSet en wordDTO.
    //final List<WordDTO> words = [];
    //for (var map in resultSet) {
    //  var wordDTO = WordDTO.fromJson(map);
    //  words.add(wordDTO);
   // }
    return listeDeMesMots;
 //   final Database db = await instance.database;
 //   final resultSet = await db.rawQuery("SELECT * FROM Words");
//    final List<WordDTO> results = <WordDTO> [];
 //   for(var r in resultSet){
 //     var word = WordDTO.fromResultSet(r);
 //     results.add(word);
 //   }
  //  return Future.value(results);
  }

  /// Récupére le nombre de mots présents dans la table
  Future<int> countWords() async {
    var res = await _database!.rawQuery("SELECT COUNT(*) FROM Words");
    var count = Sqflite.firstIntValue(res);
    return Future.value(count);
  }
}
