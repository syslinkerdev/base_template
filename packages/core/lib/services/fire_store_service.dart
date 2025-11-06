import 'dart:io';

import 'package:core/core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path/path.dart' as path;

part 'fire_store_service.g.dart';

enum FirestoreMethod {
  add,
  set,
  update,
  delete,
}

@riverpod
FirestoreService firestoreService(Ref ref) {
  return FirestoreService(
      firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);
}

class FirestoreService {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirestoreService({required this.firestore, required this.storage});

  // Handle Firestore operations based on the method type
  Future<void> _handle({
    required FirestoreMethod method,
    required String collectionPath,
    String? documentId,
    Map<String, dynamic> data = const {},
  }) async {
    try {
      late DocumentReference docRef;
      if (documentId != null) {
        docRef = firestore.collection(collectionPath).doc(documentId);
      }

      switch (method) {
        case FirestoreMethod.add:
          final docRef = firestore.collection(collectionPath);
          await handleAsyncError(
            title: 'Adding document failed',
            operation: () => docRef.add(data),
          );
          break;
        case FirestoreMethod.set:
          await handleAsyncError(
            title: 'Setting document failed',
            operation: () => docRef.set(data),
          );
          break;
        case FirestoreMethod.update:
          await handleAsyncError(
            title: 'Updating document failed',
            operation: () => docRef.update(data),
          );
          break;
        case FirestoreMethod.delete:
          await handleAsyncError(
            title: 'Deleting document failed',
            operation: () => docRef.delete(),
          );
          break;
      }
    } catch (e) {
      // Handle error if needed
      //print('Firestore operation failed: $e');
      rethrow; // Re-throw the error to be caught by the caller if necessary
    }
  }

  // CRUD Operations using Firestore

  // Create a new document with a generated ID
  Future<void> createDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    await _handle(
      method: FirestoreMethod.add,
      collectionPath: collectionPath,
      data: data,
    );
  }

  // Set a document with a specific ID
  Future<void> setDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    //print('in');
    await _handle(
      method: FirestoreMethod.set,
      collectionPath: collectionPath,
      documentId: documentId,
      data: data,
    );
  }

  // Update an existing document
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _handle(
      method: FirestoreMethod.update,
      collectionPath: collectionPath,
      documentId: documentId,
      data: data,
    );
  }

  // Delete a document
  Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    await _handle(
      method: FirestoreMethod.delete,
      collectionPath: collectionPath,
      documentId: documentId,
    );
  }

  // **Additional Useful Functions**

  Future<List<T>> getAllDocuments<T>({
    required String collectionPath,
    required T Function(QueryDocumentSnapshot<Map<String, dynamic>>) converter,
  }) async {
    final documents = await handleAsyncError(
      title: 'Fetching failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final snapshot = await collectionRef.get();
        return snapshot.docs.map(converter).toList();
      },
    );
    return documents;
  }

  Stream<List<T>> getDocumentsStream<T>({
    required String collectionPath,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) {
    final collectionRef = firestore.collection(collectionPath);

    return collectionRef.snapshots().map((snapshot) {
      // print('📥 Firestore snapshot received: ${snapshot.docs.length} docs');

      return snapshot.docs.map((doc) {
        // print('👉 Raw doc: ${doc.data()}');
        try {
          final converted = converter(doc);
          // print('✅ Converted: $converted');
          return converted;
        } catch (e) {
          // print('❌ Conversion failed for docId=${doc.id}');
          // print('❌ Raw: ${doc.data()}');
          // print('❌ Error: $e');
          rethrow; // Let the error bubble up so you see the stack trace
        }
      }).toList();
    }).handleError((error, stackTrace) {
      // print('🔥 Error in getDocumentsStream: $error');
      throw convertToAppException(title: 'Oops!', exception: error);
    });
  }

  Stream<List<T>> getDocumentsStreamWithQuery<T>({
    required String collectionPath,
    required Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>> collectionRef,
    ) buildQuery,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) {
    final collectionRef = firestore.collection(collectionPath);

    final query = buildQuery(collectionRef);

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map(converter).toList();
    }).handleError((error, stackTrace) {
      //print('Error in getDocumentsStreamWithQuery: $error');
      throw convertToAppException(title: 'Oops!', exception: error);
    });
  }

  Future<T> getDocument<T>({
    required String collectionPath,
    required String documentId,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) async {
    final document = await handleAsyncError(
      title: 'Fetching failed',
      operation: () async {
        final docRef = firestore.collection(collectionPath).doc(documentId);
        final snapshot = await docRef.get();
        return converter(snapshot);
      },
    );
    return document;
  }

  Future<T?> getDocumentByComparison<T>({
    required String collectionPath,
    required String fieldName,
    required dynamic fieldValue,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) async {
    final querySnapshot = await handleAsyncError(
      title: 'Fetching failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final snapshot =
            await collectionRef.where(fieldName, isEqualTo: fieldValue).get();
        return snapshot.docs;
      },
    );

    if (querySnapshot.isNotEmpty) {
      final document = converter(querySnapshot.first);
      return document;
    } else {
      return null;
    }
  }

  Stream<T?> getDocumentByComparisonStream<T>({
    required String collectionPath,
    required String fieldName,
    required dynamic fieldValue,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) {
    final collectionRef = firestore.collection(collectionPath);
    return collectionRef
        .where(fieldName, isEqualTo: fieldValue)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.isNotEmpty ? converter(snapshot.docs.first) : null)
        .handleError((error, stackTrace) {
      //print('An error occurred: $error');
      throw convertToAppException(title: 'Oops!', exception: error);
    });
  }

  Stream<T?> getDocumentStream<T>({
    required String collectionPath,
    required String documentId,
    required T Function(DocumentSnapshot<Map<String, dynamic>>) converter,
  }) {
    //print("🔌 getDocumentStream attached → $collectionPath/$documentId");

    final docRef = firestore.collection(collectionPath).doc(documentId);

    return docRef.snapshots().map((snapshot) {
      return snapshot.exists ? converter(snapshot) : null;
    }).handleError((error, stackTrace) {
      throw convertToAppException(title: 'Oops!', exception: error);
    });
  }

  Future<bool> deleteDocumentByComparison({
    required String collectionPath,
    required String fieldName,
    required dynamic fieldValue,
  }) async {
    //print('$fieldValue -------------------');
    final querySnapshot = await handleAsyncError(
      title: 'Fetching failed',
      operation: () async {
        //print('at delete ------------------- ');
        final collectionRef = firestore.collection(collectionPath);
        final snapshot =
            await collectionRef.where(fieldName, isEqualTo: fieldValue).get();
        return snapshot.docs;
      },
    );
    //print('$querySnapshot --------------          -----------');
    if (querySnapshot.isNotEmpty) {
      final docRef = querySnapshot.first.reference;
      await handleAsyncError(
        title: 'Deletion failed',
        operation: () async {
          //print('at delete ------inner------------- ');

          await docRef.delete();
        },
      );
      return true; // Return true if the document was successfully deleted
    } else {
      return false; // Return false if no document is found
    }
  }

  Future<String> uploadImage({
    required File imageFile,
    required String destinationStoragePath,
  }) async {
    final ext = path.extension(imageFile.path); // e.g., ".jpg"
    final hasExtension = path.extension(destinationStoragePath).isNotEmpty;

    final fullPath =
        hasExtension ? destinationStoragePath : '$destinationStoragePath$ext';

    final downloadUrl = await handleAsyncError(
      title: 'Image upload failed',
      operation: () async {
        final ref = storage.ref().child(fullPath);
        final uploadTask = ref.putFile(imageFile);
        await uploadTask.whenComplete(() {});
        return await ref.getDownloadURL();
      },
    );

    return downloadUrl;
  }

  Future<void> deleteImage({required String storagePath}) async {
    return handleAsyncError(
      title: 'Image delete failed',
      operation: () async {
        // Get a reference to the file in Firebase Storage
        final ref = storage.ref().child(storagePath);

        // Delete the file
        await ref.delete();
      },
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    final url = await handleAsyncError(
      title: 'Image loading failed',
      operation: () async {
        final ref = storage.ref().child(imagePath);
        return ref.getDownloadURL();
      },
    );
    return url;
  }

  Future<List<T>> getFieldValuesList<T>({
    required String collectionPath,
    required String fieldName,
  }) async {
    final fieldValues = await handleAsyncError<List<T>>(
      title: 'Fetching field values failed',
      operation: () async {
        final collectionRef =
            FirebaseFirestore.instance.collection(collectionPath);
        final snapshot = await collectionRef.get();

        // Extract the specific field values from each document
        return snapshot.docs
            .map((doc) =>
                doc.get(fieldName) as T) // Use get(fieldName) for clarity
            .where((value) => value != null) // Filter out null values
            .toList();
      },
    );
    return fieldValues;
  }

  Future<List<T>> getFieldValuesToSetList<T>({
    required String collectionPath,
    required String fieldName,
  }) async {
    final fieldValues = await handleAsyncError<List<T>>(
      title: 'Fetching field values failed',
      operation: () async {
        final collectionRef =
            FirebaseFirestore.instance.collection(collectionPath);
        final snapshot = await collectionRef.get();

        // Extract the specific field values from each document
        return snapshot.docs
            .map((doc) =>
                doc.get(fieldName) as T) // Use get(fieldName) for clarity
            .where((value) => value != null) // Filter out null values
            .toSet()
            .toList();
      },
    );
    return fieldValues;
  }

  Future<List<T>> getFieldValuesByCondition<T>({
    required String collectionPath,
    required String conditionFieldName,
    required dynamic conditionValue,
    required String targetFieldName,
  }) async {
    final fieldValues = await handleAsyncError<List<T>>(
      title: 'Fetching field values failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final querySnapshot = await collectionRef
            .where(conditionFieldName, isEqualTo: conditionValue)
            .get();

        // Extract target field values from documents
        return querySnapshot.docs
            .map((doc) => doc.get(targetFieldName) as T)
            .where((value) => value != null) // Filter out null values
            .toList();
      },
    );

    return fieldValues;
  }

  Future<List<T>> getDocumentsByCondition<T>({
    required String collectionPath,
    required String conditionFieldName,
    required dynamic conditionValue,
    required T Function(QueryDocumentSnapshot<Map<String, dynamic>>) converter,
  }) async {
    final documents = await handleAsyncError<List<T>>(
      title: 'Fetching documents failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final querySnapshot = await collectionRef
            .where(conditionFieldName, isEqualTo: conditionValue)
            .get();

        // Convert documents using the provided converter
        return querySnapshot.docs.map(converter).toList();
      },
    );

    return documents;
  }

  Future<List<T>> getDocumentsWithQuery<T>({
    required String collectionPath,
    required Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>> collectionRef,
    ) buildQuery,
    required T Function(QueryDocumentSnapshot<Map<String, dynamic>>) converter,

    /// 🚩 pass `true` if you want fresh data only (server-only fetch)
    bool serverOnly = false,
  }) async {
    //print('serverOnly $serverOnly');
    return await handleAsyncError<List<T>>(
      title: 'Fetching documents failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final query = buildQuery(collectionRef);

        final querySnapshot = await query.get(
          serverOnly
              ? const GetOptions(source: Source.server) // 🔥 server-only
              : null, // ⚡ cache + server
        );

        return querySnapshot.docs.map(converter).toList();
      },
    );
  }

  Future<List<T>> getDocumentsByFilter<T>({
    required String collectionPath,
    required String fieldName,
    required List<dynamic> fieldValues,
    required T Function(QueryDocumentSnapshot<Map<String, dynamic>>) converter,
  }) async {
    final documents = await handleAsyncError<List<T>>(
      title: 'Fetching documents failed',
      operation: () async {
        final collectionRef = firestore.collection(collectionPath);
        final querySnapshot =
            await collectionRef.where(fieldName, whereIn: fieldValues).get();

        // Convert documents using the provided converter
        return querySnapshot.docs.map(converter).toList();
      },
    );
    return documents;
  }

  /// Updates specific fields in a document without overwriting the entire doc.
  /// Uses Firestore's `SetOptions(merge: true)` under the hood.
  Future<void> updateDocumentFields({
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    final docRef = firestore.doc(documentPath);

    await handleAsyncError(
      title: 'Partial update failed',
      operation: () => docRef.set(data, SetOptions(merge: true)),
    );
  }
}

extension FirestoreBatching on FirestoreService {
  /// Executes multiple Firestore writes automatically chunked into 500 operations per batch.
  ///
  /// Each operation should be a function that accepts a [WriteBatch].
  /// Example:
  /// ```dart
  /// await firestoreService.runBatchedWrites([
  ///   (batch) => batch.set(firestore.collection('users').doc('1'), {'name': 'A'}),
  ///   (batch) => batch.update(firestore.collection('users').doc('2'), {'age': 30}),
  ///   (batch) => batch.delete(firestore.collection('orders').doc('3')),
  /// ]);
  /// ```
  Future<void> runBatchedWrites(
    List<void Function(WriteBatch batch)> operations,
  ) async {
    if (operations.isEmpty) return;

    const int maxBatchSize = 500;
    int start = 0;

    while (start < operations.length) {
      final end = (start + maxBatchSize < operations.length)
          ? start + maxBatchSize
          : operations.length;

      final batch = firestore.batch();

      // apply this chunk of operations
      for (int i = start; i < end; i++) {
        operations[i](batch);
      }

      await handleAsyncError(
        title: 'Batch commit failed',
        operation: () async => await batch.commit(),
      );

      start = end;
    }
  }
}
