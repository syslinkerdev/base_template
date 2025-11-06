import 'package:models/models.dart';

class GlobalCacheService {
  // === Singleton setup ===
  GlobalCacheService._internal();
  static final GlobalCacheService instance = GlobalCacheService._internal();

  // === Caches ===
  final Map<String, Product> _productCache = {};
  UserX? _userCache; // Only one logged-in UserX
  UserX? _clientCache; // Only one client UserX (for admin ops)

  // === Product CRUD ===
  void addProduct(Product product) {
    _productCache[product.id] = product;
  }

  Product? getProduct(String? id) => _productCache[id];

  void updateProduct(Product product) {
    if (_productCache.containsKey(product.id)) {
      _productCache[product.id] = product;
    }
  }

  void deleteProduct(String id) => _productCache.remove(id);

  bool hasProduct(String id) => _productCache.containsKey(id);

  List<Product> getAllProducts() => _productCache.values.toList();

  void clearProducts() => _productCache.clear();

  // === User CRUD ===
  void setUser(UserX user) => _userCache = user;

  UserX? getUser() => _userCache;

  void updateUser(UserX updatedUser) {
    if (_userCache != null && _userCache!.uid == updatedUser.uid) {
      _userCache = updatedUser;
    }
  }

  bool hasUser() => _userCache != null;

  void clearUser() => _userCache = null;

  // === Client CRUD (for admin) ===
  void setClient(UserX user) => _clientCache = user;

  UserX? getClient() => _clientCache;

  void updateClient(UserX updatedUser) {
    if (_clientCache != null && _clientCache!.uid == updatedUser.uid) {
      _clientCache = updatedUser;
    }
  }

  bool hasClient() => _clientCache != null;

  void clearClient() => _clientCache = null;

  // === Clear all cache ===
  void clearAll() {
    // final clearedUser = _userCache?.uid;
    // final clearedClient = _clientCache?.uid;
    // final clearedProducts = _productCache.length;

    clearProducts();
    clearUser();
    clearClient();

    //print(
    // 'Cleared user: $clearedUser, client: $clearedClient, products: $clearedProducts');
  }

  // === Debug helper ===
  void dumpCache() {
    //print('--- GlobalCacheService dump ---');
    //print('User: ${_userCache?.uid}');
    //print('Client: ${_clientCache?.uid}');
    //print('Products: ${_productCache.keys.toList()}');
  }
}
