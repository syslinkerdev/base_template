part of 'package:repo/repo.dart';

extension UsersRepository on DairyB2bRepository {
  // To fetch list of Admins and Super Admins
  Future<List<UserX>> fetchAdminsAndSuperAdmins() async {
    return await _service.getDocumentsWithQuery<UserX>(
      collectionPath: DbPathManager.users(),
      buildQuery: (collection) => collection.where(
        DbStandardFields.role,
        whereIn: [Role.admin.name],
      ),
      converter: (snapshot) {
        // print('Fetched Admin: ${snapshot.data()}');
        return UserX.fromJson(snapshot.data());
      },
    );
  }

  Stream<UserX?> fetchUserStream({required String uId}) {
    final response = _service.getDocumentStream(
      collectionPath: DbPathManager.users(),
      documentId: uId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );

    return response;
  }

  Future<UserX?> fetchUserByComparisonPhone({required String phoneNumber}) {
    final response = _service.getDocumentByComparison(
      collectionPath: DbPathManager.users(),
      fieldName: DbStandardFields.phoneNumber,
      fieldValue: phoneNumber,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Future<UserX?> fetchLatestDeletedUserByPhone(String phoneNumber) async {
    final results = await _service.getDocumentsWithQuery<UserX>(
      collectionPath: DbPathManager.deletedUsers(),
      buildQuery: (collection) => collection
          .where(DbStandardFields.phoneNumber, isEqualTo: phoneNumber)
          .orderBy(DbStandardFields.createdAt, descending: true)
          .limit(1),
      converter: (doc) => UserX.fromJson(doc.data()),
    );
    return results.isNotEmpty ? results.first : null;
  }

  Stream<UserX?> fetchUserByComparisonPhoneStream(
      {required String phoneNumber}) {
    //print('phoneNumber ${phoneNumber}');
    final response = _service.getDocumentByComparisonStream(
      collectionPath: DbPathManager.users(),
      fieldName: DbStandardFields.phoneNumber,
      fieldValue: phoneNumber,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Future<UserX?> fetchUser({required String documentId}) async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.users(),
      documentId: documentId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Future<UserX?> fetchDeletedUser({required String documentId}) async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.deletedUsers(),
      documentId: documentId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  // To fetch Developer
  Future<UserX?> fetchAppManagement({required String documentId}) async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.users(),
      documentId: documentId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return UserX.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  Stream<List<UserX>> usersStream() => _service.getDocumentsStream<UserX>(
        collectionPath: DbPathManager.users(),
        converter: (snapshot) => UserX.fromJson(snapshot.data()!),
      );
}
