part of 'package:repo/repo.dart';

/// Provides a single instance of [DairyB2bRepository].
@riverpod
DairyB2bRepository dairyB2bRepository(Ref ref) {
  return DairyB2bRepository(service: ref.watch(firestoreServiceProvider));
}

/// Central repository for all Firestore operations and shared data logic.
///
/// This is the main data access layer for the DairyB2b system.
/// Client-specific or app-specific repositories can extend this base class.
class DairyB2bRepository {
  DairyB2bRepository({required FirestoreService service}) : _service = service;
  final FirestoreService _service;

  // Core methods will be extended from parts inside repo/
}
