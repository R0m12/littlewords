import 'dart:async';
import 'package:littlewords/dto/word_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

///Classe permettant de gérer la base de données.
class DbHelper{
  static const dbName = 'littlewords.db';
  static const dbPathName = 'littlewords.path';
  static const dbVersion = 1;

  //Instance de connexion à la db
  static Database? _database;

  //Definition d'un constructeur privé
  DbHelper._privateConstructor();

  //Création variable instance permettant d'obtenir un acces au singleton
  static final DbHelper instance = DbHelper._privateConstructor();

  //Getter  de database avec init si necessaire
  Future<Database> get database async => _database ??= await _init();

  //Initialisation de database
  Future<Database> _init() async{
    final String dbPath = await getDatabasesPath();

    //On ouvre la connexion
    return await openDatabase(
      join(dbPath, dbPathName),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: dbVersion,
    );
  }

  ///Déclenché lorsque la base de données n'existe pas sur le device
  FutureOr<void> _onCreate(Database db, int version){
    const String createWordsTableQuery = 'CREATE TABLE words (uid integer PRIMARY KEY AUTOINCREMENT, content VARCHAR(200) NOT NULL)';
    db.execute(createWordsTableQuery);
  }

  ///Déclenché lorsque le numéro de version est augmenté
  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion){
    const String dropWordsTableQuery = 'DROP TABLE IF EXISTS words';
    db.execute(dropWordsTableQuery);
  }

  /// Insertion d'un mot dans la base de données
  Future<void> insert(final WordDTO wordDTO) async {
    Database db = await instance.database;
    final String insertWord = "INSERT into words (content, author, latitude, longitude) values ('${wordDTO.content}',"
        "'${wordDTO.author}', '${wordDTO.latitude}', '${wordDTO.longitude}') ";
    return db.execute(insertWord);
  }

  /// Suppression d'un mot dans la base de données
  Future<void> delete(final WordDTO wordDTO) async {
    Database db = await instance.database;
    final String deleteWord = "DELETE FROM words WHERE content = '${wordDTO.content}'";
    return db.execute(deleteWord);
  }

  /// Récupération de tous les mots de la base de données
  Future<List<WordDTO>> getAllWords() async {
    final Database db = await instance.database;

    final resultSet = await db.rawQuery("SELECT * from words");

    final List<WordDTO> results = <WordDTO> [];

    for(var r in resultSet){
      var word = WordDTO.fromResultSet(r);
      results.add(word);
    }
    return Future.value(results);
  }

  /// Récupére le nombre de mots présents dans la table
  Future<int> countWords() async {
    final Database db = await instance.database;
    var res = await db.rawQuery("Select count(*) from words");
    var count = Sqflite.firstIntValue(res);
    return Future.value(count);
  }
}
