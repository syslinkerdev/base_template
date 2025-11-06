part of 'package:repo/repo.dart';

extension MetaRepository on DairyB2bRepository {
  Future<List<String>> fetchPhoneNos() async {
    final response = await _service.getFieldValuesList<String>(
        collectionPath: DbPathManager.users(),
        fieldName: DbStandardFields.phoneNumber);
    return response;
  }

  Future<List<String>> fetchUniqueDeletedPhoneNos() async {
    final response = await _service.getFieldValuesList<String>(
        collectionPath: DbPathManager.deletedUsers(),
        fieldName: DbStandardFields.phoneNumber);
    return response;
  }

  // To fetch ProductMaker Data : brands,categories,units etc...
  Future<ProductMaker?> fetchProductMaker() async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.appData(),
      documentId: ProductMaker.productMakerDocId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return ProductMaker.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

  // To fetch OrderRules Data : start,end order time, enable etc...
  Stream<OrderRules?> fetchOrderRules() {
    final response = _service.getDocumentStream(
      collectionPath: DbPathManager.appData(),
      documentId: OrderRules.orderRulesDocId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return OrderRules.fromJson(data);
        } else {
          return null;
        }
      },
    );
    return response;
  }

// To fetch list of Avatars
  Future<List<Avatar>> fetchAvatars() async {
    final response = await _service.getDocument(
      collectionPath: DbPathManager.appData(),
      documentId: Avatar.avatarsDocId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null && data[Avatar.avatarsFieldName] is List) {
          final list = data[Avatar.avatarsFieldName] as List;
          return list
              .whereType<Map<String, dynamic>>()
              .map((json) => Avatar.fromJson(json))
              .toList();
        }
        return <Avatar>[];
      },
    );
    return response;
  }

  Future<void> updateOrderRules(OrderRules orderRules) async {
    await _service.updateDocument(
      collectionPath: DbPathManager.appData(),
      documentId: OrderRules.orderRulesDocId,
      data: orderRules.toJson(),
    );
  }

  // To fetch list of Log
  Future<List<LogModel>> fetchLogs() async {
    final response = await _service.getAllDocuments(
      collectionPath: DbPathManager.logs(),
      converter: (snapshot) {
        final data = snapshot.data();
        return LogModel.fromJson(data);
      },
    );
    return response;
  }
}
