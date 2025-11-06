import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

class PushData extends StatelessWidget {
  const PushData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore JSON Import',
      home: Scaffold(
        appBar: AppBar(title: const Text('Import JSON to Firestore')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                final data = await loadJsonData();
                final collectionName = data['collection'] as String;
                final documents =
                    List<Map<String, dynamic>>.from(data['documents']);

                await uploadJsonToFirestore(documents, collectionName);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('✅ Data uploaded successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('❌ Error: $e')),
                );
              }
            },
            child: const Text('Upload JSON Data'),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> loadJsonData() async {
  final jsonString =
      await rootBundle.loadString('assets/products_collection.json');
  return json.decode(jsonString) as Map<String, dynamic>;
}

Future<void> uploadJsonToFirestore(
    List<Map<String, dynamic>> documents, String collectionName) async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();

  for (var doc in documents) {
    final docId = doc['id'].toString();
    final ref = firestore.collection(collectionName).doc(docId);
    batch.set(ref, doc);
  }

  await batch.commit();
}

class SeedAppDataPage extends StatefulWidget {
  const SeedAppDataPage({super.key});

  @override
  State<SeedAppDataPage> createState() => _SeedAppDataPageState();
}

class _SeedAppDataPageState extends State<SeedAppDataPage> {
  bool _isUploading = false;
  String _status = "Idle";

  Future<Map<String, dynamic>> _loadJson() async {
    final jsonString = await rootBundle.loadString('assets/app_data.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  Future<void> _uploadToFirestore(Map<String, dynamic> jsonData) async {
    final firestore = FirebaseFirestore.instance;
    final collectionName = jsonData["collection"];
    final documents = List<Map<String, dynamic>>.from(jsonData["documents"]);

    setState(() => _status = "Uploading ${documents.length} documents...");

    final batch = firestore.batch();

    for (var doc in documents) {
      final docId = doc["id"];
      final docData = Map<String, dynamic>.from(doc["data"]);
      final ref = firestore.collection(collectionName).doc(docId);
      batch.set(ref, docData);
    }

    await batch.commit();

    setState(() => _status = "✅ Upload completed successfully!");
  }

  Future<void> _handleUpload() async {
    try {
      setState(() {
        _isUploading = true;
        _status = "Loading JSON...";
      });

      final jsonData = await _loadJson();
      await _uploadToFirestore(jsonData);
    } catch (e) {
      setState(() => _status = "❌ Error: $e");
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seed App Data → Firestore"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _status,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud_upload_outlined),
              label: Text(_isUploading ? "Uploading..." : "Upload JSON Data"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: _isUploading ? null : _handleUpload,
            ),
          ],
        ),
      ),
    );
  }
}
