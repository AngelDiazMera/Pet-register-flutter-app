import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_register/models/mascota_model.dart';
import 'package:pet_register/models/persona_model.dart';
import 'package:sqflite/sqflite.dart';

// USO DE SINGLETON PARA QUE LA INSTANCIA SIEMPRE SEA LA MISMA
class DBProvider {
  static Database _database;
  //Mire la sentencia DBProvider._Private() <- constructor privado(en singleton)
  static final DBProvider db =
      DBProvider._(); //Instancia de la clase personalizada
  // Constructor privado para que siempre sea el mismo
  DBProvider._();

  Future<Database> get database async {
    // Por si no lo ha instanciado
    if (_database != null) return _database;
    // Accede a la base de datos ya creada
    _database = await initDb();
    return _database;
  }

  // HASTA AQUÍ TERMINA LA ESTRUCTURA DE UN SINGLETON

  Future<Database> initDb() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(
        documentsDirectory.path, 'PetsApp2.db'); // Para unir pedazos del path
    print(path);
    // Crear nase de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Persona(
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre        TEXT,
            apellido      TEXT,
            sexo          TEXT,
            edad          INTEGER
          );
      ''');
        await db.execute('''
          CREATE TABLE Mascota(
            id            INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo          TEXT,
            nombreMascota TEXT,
            edadMascota   INTEGER,
            idDuenio      INTEGER,
            FOREIGN KEY(idDuenio) REFERENCES Persona(id)
          );
        ''');

        print('Base de datos creada');
      },
    );
  }

  // INSERT  nueva persona
  Future<int> nuevaMascota({PersonaModel persona, MascotaModel mascota}) async {
    // print('');
    final db = await database;
    // Consulta para revisar si esa persona ya fue registrada
    final query = await db.query('Persona',
        where:
            'nombre LIKE ? AND apellido LIKE ? AND sexo LIKE ? AND edad LIKE ?',
        whereArgs: [
          persona.nombre,
          persona.apellido,
          persona.sexo,
          persona.edad
        ]);
    // En caso de que la persona ya haya sido registrada
    if (query.isNotEmpty) {
      // print('Ya está registrado');
      // print(persona);
      PersonaModel queryPersona = PersonaModel.fromJson(query.first);
      mascota.idDuenio = queryPersona.id; // Asignación del dueño
      // print(mascota);
      // Consulta de verificación de la existencia de esa mascota asociada
      final queryMascota = await db.query('Mascota',
          where:
              'tipo LIKE ? AND nombreMascota LIKE ? AND edadMascota LIKE ? AND idDuenio LIKE ?',
          whereArgs: [
            mascota.tipo,
            mascota.nombreMascota,
            mascota.edadMascota,
            mascota.idDuenio
          ]);
      // Si la mascota ya está registrada
      if (queryMascota.isNotEmpty) {
        // print('La mascota ya ha sido registrada');
        return 0;
      }
      // Si la mascota no ha sido registrada
      final resMascota = await db.insert('Mascota', mascota.toJson());
      return resMascota;
    }
    // En caso de que la persona no haya sido registrada.
    // print('No hay personas');
    // print(persona);
    final resPersona = await db.insert('Persona', persona.toJson());
    mascota.idDuenio = resPersona;
    // print(mascota);
    final resMascota = await db.insert('Mascota', mascota.toJson());
    return resMascota;
  }

  Future<List<Map<String, dynamic>>> getAllMascotas() async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT 
        P.nombre, 
        P.apellido, 
        P.sexo, 
        P.edad,
        M.tipo as tipoMascota,  
        M.nombreMascota, 
        M.edadMascota 
      FROM Mascota M INNER JOIN Persona P
      ON P.id = M.idDuenio;''');
    return res.isNotEmpty ? res : [];
  }

  // //DELETE
  Future deleteAll() async {
    final db = await database;
    await db.delete('Mascota');
    await db.delete('Persona');
    return;
  }

  // SELECT
  /*Future<PersonaModel> getPersonaById(int id) async {
    final db = await database;
    // El símbolo '?' es para determinar los argumentos posicionales de la búsqueda
    final res = await db.query('Persona', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty
        ? PersonaModel.fromJson(res.first) // Obtiene el primer elemento
        : null;
  }
  
  // // UPDATE
  Future<int> updatePersona(PersonaModel nuevaPersona) async {
    final db = await database;
    final res = await db.update('Persona', nuevaPersona.toJson(),
        where: 'id = ?', whereArgs: [nuevaPersona.id]);
    return res;
  }

  // //DELETE
  Future<int> deletePersona(int id) async {
    final db = await database;
    final res = await db.delete('Persona', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllPersonas() async {
    final db = await database;
    final res = await db.delete('Persona');
    return res;
  }*/
}
