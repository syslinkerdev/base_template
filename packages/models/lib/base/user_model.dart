// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserX with _$UserX {
  const UserX._();
  const factory UserX({
    @JsonKey(name: 'uid') required String uid, // over
    @JsonKey(
        name: 'role',
        fromJson: RoleConverter.fromJsonNullable,
        toJson: RoleConverter.toJsonNullable)
    Role? role, // over
    @JsonKey(name: 'first_name') required String firstName, // over
    @JsonKey(name: 'last_name') required String lastName, // over
    @JsonKey(name: 'phone_number') required String phoneNumber, // over
    // new section over
    @JsonKey(name: 'shop_name') required String shopName,
    @JsonKey(name: 'shop_address') required Address shopAddress, //
    @JsonKey(name: 'superuser_uid') required String superuserUid,
    @JsonKey(name: 'avatar') required String avatar, // over
    @JsonKey(name: 'hashed_password') String? hashedPassword,
    @JsonKey(name: 'access_code')
    required String accessCode, // new section over
    @JsonKey(name: 'is_given') required bool isGiven,
    @JsonKey(name: 'dis_section')
    required DiscountSection? disSection, // new section
    @JsonKey(name: 'service_charges') required double serviceCharges,
    @JsonKey(name: 'basket_limit_no') int? basketLimitNo, // over
    @JsonKey(name: 'smart_baskets') List<SmartBasket>? smartBaskets, // over
    @JsonKey(
        name: 'status',
        fromJson: UserStatusConverter.fromJsonNullable,
        toJson: UserStatusConverter.toJsonNullable)
    UserStatus? status, // over
    @JsonKey(name: 'created_at', fromJson: TimeStampConverter.fromJson)
    required DateTime createdAt, // over
    @JsonKey(name: 'deleted_at', fromJson: TimeStampConverter.fromJsonNullable)
    DateTime? deletedAt,
    @JsonKey(
        name: 'deleted_by',
        fromJson: RoleConverter.fromJsonNullable,
        toJson: RoleConverter.toJsonNullable)
    Role? deletedBy,
    @JsonKey(name: 'replaced_by') String? replacedBy,
    @JsonKey(name: 'previous_uids') List<String>? previousUids,
  }) = _User;

  factory UserX.empty() => UserX(
        uid: '',
        role: Role.client,
        firstName: '',
        lastName: '',
        phoneNumber: '',
        shopName: '',
        shopAddress: Address.empty(),
        superuserUid: '',
        avatar: '',
        hashedPassword: '',
        accessCode: '',
        isGiven: false,
        basketLimitNo: 7,
        smartBaskets: [],
        disSection: DiscountSection.empty(),
        serviceCharges: 10,
        status: UserStatus.active,
        createdAt: DateTime.now(),
        deletedAt: null,
        deletedBy: null,
        replacedBy: null,
        previousUids: null,
      );

  bool get isEmpty => this.uid == UserX.empty().uid;
  bool get isNotEmpty => !isEmpty;

  factory UserX.fromJson(Map<String, dynamic> json) => _$UserXFromJson(json);
}

extension UserXApi on UserX {
  Map<String, dynamic> toDocument() => {
        'uid': uid,
        'phone_number': phoneNumber,
        'role': RoleConverter.toJsonNullable(role ?? UserX.empty().role!),
        'first_name': firstName,
        'last_name': lastName,
        'shop_name': shopName,
        'shop_address': shopAddress.toJson(),
        'superuser_uid': superuserUid,
        'avatar': avatar,
        'hashed_password': hashedPassword ?? '',
        'access_code': accessCode,
        'is_given': isGiven,
        'dis_section': disSection?.toDocument(),
        'service_charges': serviceCharges,
        'basket_limit_no': basketLimitNo,
        'smart_baskets':
            smartBaskets?.map((basket) => basket.toDocument()).toList() ?? [],
        'status':
            UserStatusConverter.toJsonNullable(status ?? UserX.empty().status!),
        'created_at': createdAt,
        'deleted_at': deletedAt,
        'deleted_by': RoleConverter.toJsonNullable(deletedBy),
        'replaced_by': replacedBy,
        'previous_uids': previousUids,
      };
}

extension UserXHelpers on UserX {
  String get fullName => '$firstName $lastName';

  bool get isCompleteUser {
    final hasPassword = hashedPassword?.isNotEmpty == true;
    final isNotAppManagement = role != Role.appManagement;
    return hasPassword && isNotAppManagement;
  }
}

extension UserXListHelpers on List<UserX> {
  /// Only complete users (has password + not appManagement)
  List<UserX> get completeUsers => where(
        (u) => u.isCompleteUser && u.role != Role.appManagement,
      ).toList();

  /// Only admins
  List<UserX> get admins => where((u) => u.role == Role.admin).toList();

  /// Only clients
  List<UserX> get clients => where((u) => u.role == Role.client).toList();

  /// Only App Management role
  List<UserX> get appManagement =>
      where((u) => u.role == Role.appManagement).toList();

  /// Only active users (status == active)
  List<UserX> get activeUsers =>
      where((u) => u.status == UserStatus.active).toList();

  /// Find user by UID
  UserX? byUid(String uid) =>
      firstWhere((u) => u.uid == uid, orElse: () => UserX.empty());

  /// Sort by first name
  List<UserX> get sortedByName {
    final copy = [...this];
    copy.sort((a, b) => a.firstName.compareTo(b.firstName));
    return copy;
  }
}
