class DbPathManager {
  const DbPathManager._();
  // Collection paths
  static String users() => 'users';
  static String deletedUsers() => 'deleted_users';
  static String avatars() => 'avatars';
  static String appData() => 'app_data';
  static String products() => 'products';
  static String orders() => 'orders';
  static String discountSections() => 'discount_sections';
  static String logs() => 'logs';
  static String masterOrders() => 'master_orders';
  static String actualDeliveries() => 'actual_deliveries';

  // Document paths
  static String user({required String userId}) => 'users/$userId';
  static String deletedUser({required String deletedUserId}) =>
      'deleted_users/$deletedUserId';
  static String appManagement() => 'appManagement';
  static String product({required String productId}) => 'products/$productId';
  static String order({required String orderId}) => 'orders/$orderId';
  static String discountSection({required String sectionId}) =>
      'discount_sections/$sectionId';
  static String log({required String logId}) => 'logs/$logId';
  static String masterOrder({required String id}) => 'master_orders/$id';
  static String actualDelivery({required String id}) => 'actual_deliveries/$id';
  static String productLines({required String path}) => '$path/product_lines';
  static String demandLines({required String path}) => '$path/demand_lines';
}

class DbStandardFields {
  const DbStandardFields._();
  static const String uid = 'uid';
  static const String phoneNumber = 'phone_number';
  static const String role = 'role';
  static const String hashedPassword = 'hashed_password';
  static const String avatar = 'avatar';
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String shopName = 'shop_name';
  static const String shopAddress = 'shop_address';
  static const String accessCode = 'access_code';
  static const String id = 'id';
  static const String userUid = 'user_uid';
  // static const String creationTime = 'creation_time';
  // static const String createdTime = 'created_time';
  static const String orderId = 'order_id';
  static const String smartBaskets = 'smart_baskets';
  static const String isGiven = 'is_given';
  static const String status = 'status';
  static const String price = 'price';
  static const String packSize = 'pack_size';
  static const String productDiscounts = 'product_discounts';
  static const String createdAt = 'created_at';
  static const String createdBy = 'created_by';
  static const String updatedAt = 'updated_at';
  static const String updatedBy = 'updated_by';
  static const String deletedAt = 'deleted_at';
  static const String deletedBy = 'deleted_by';
  static const String deliveryDate = 'delivery_date';
  static const String disSection = 'dis_section';
  static const String serviceCharges = 'service_charges';
}

class DbStandardValues {
  const DbStandardValues._();
}

class StoragePathManger {
  const StoragePathManger._();
  // Collection paths
  static String StorageRoot() => '/storage_root';
  static String avatars() => '${StorageRoot()}/avatars';
  static String brands() => '${StorageRoot()}/brands';
  static String categories() => '${StorageRoot()}/categories';
  static String products({required String brandName}) =>
      '${StorageRoot()}/products/$brandName';

  static String avatar({required String name}) => '${avatars()}/$name';
  static String brand({required String name}) => '${brands()}/$name';
  static String category({required String name}) => '${categories()}/$name';
  static String product(
          {required String brandName, required String productName}) =>
      '${products(brandName: brandName)}/$productName';
}
