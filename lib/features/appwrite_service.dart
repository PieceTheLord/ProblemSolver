import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_educational_shop/constants/appwrite.dart';

class AppwriteService {
  late Client client;
  late Account account;
  late Databases databases;
  late TablesDB tablesDB;

  AppwriteService() {
    client = Client()
        .setEndpoint(AppwriteConstants.projectEndpoint)
        .setProject(AppwriteConstants.projectId)
        .setDevKey(AppwriteConstants.devKey);
    account = Account(client);
    databases = Databases(client);
    tablesDB = TablesDB(client);
  }

  Future<User?> getCurrentUser() async {
    try {
      return await account.get();
    } catch (e) {
      return null;
    }
  }

  Future addKPI({required String title, required String goal}) async {
    await tablesDB.createRow(
      databaseId: AppwriteConstants.databaseId,
      tableId: AppwriteConstants.kpisTableID,
      rowId: ID.unique(),
      data: {"title": title, "Goal": goal},
    );
  }

  Future getAllKPIs() async {
    final req = await tablesDB.listRows(
      databaseId: AppwriteConstants.databaseId,
      tableId: AppwriteConstants.kpisTableID,
      queries: [
        Query.select(['title', 'goal']),
      ],
    );
    return req.rows;
  }

  /// Retrieve all docs from users collection
  Future<List<Row>> getUsers() async {
    final req = await tablesDB.listRows(
      databaseId: AppwriteConstants.databaseId,
      tableId: AppwriteConstants.userTableID,
      queries: [
        Query.select(['email', 'password', 'created_at']),
      ],
    );
    return req.rows;
  }

  Future<void> insertKpiData({
    required String title,
    required String goal,
  }) async {
    try {
      await tablesDB.createRow(
        databaseId: AppwriteConstants.databaseId,
        tableId: AppwriteConstants.kpisTableID,
        rowId: ID.unique(),
        data: {"title": title, "goal": goal},
      );
    } on AppwriteException catch (e) {
      throw AppwriteException("Appwrite Error while inserting KPi data -> $e");
    } catch (e) {
      throw Exception("Error while inserting data -> $e");
    }
  }

  /// Insert user's data in users collection
  Future<void> insertUserData({
    required String email,
    required String password,
  }) async {
    try {
      final userData = account.get();
      print(userData);
      await tablesDB.createRow(
        databaseId: AppwriteConstants.databaseId,
        tableId: AppwriteConstants.userTableID,
        rowId: ID.unique(),
        data: {
          "created_at": DateTime.now().toString(),
          "email": (await account.get()).email,
          "password": password,
        },
      );
    } on AppwriteException catch (e) {
      throw AppwriteException("Appwrite Error while user nserting data -> $e");
    } catch (e) {
      throw Exception("Error while inserting data -> $e");
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
    } on Exception catch (e) {
      throw Exception("Session not created! $e");
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e) {
      throw AppwriteException('Error in appwrite_service.dart in logout $e');
    }
  }


  Future<void> deleteCurrentKPI(String rowID) async {
    try {
      await tablesDB.deleteRow(databaseId: AppwriteConstants.databaseId, tableId: AppwriteConstants.kpisTableID, rowId: rowID);
        
    } on AppwriteException catch(e) {
      throw AppwriteException('Error in appwrite_service.dart in deleteCurrentKPI -> $e }');
    }
  }
}

final appwrite = AppwriteService();
