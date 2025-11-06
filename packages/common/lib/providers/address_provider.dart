import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

part 'address_provider.g.dart';
part 'address_provider.freezed.dart';

@riverpod
class AddressManager extends _$AddressManager {
  @override
  FutureOr<AddressState> build() => const AddressState();

  Future<AddressState> fetchAddressState() async {
    final place = await getPlace();
    return AddressState(
      placemark: place,
    );
  }

  Future<Placemark?> getPlace() async {
    try {
      state = const AsyncValue.loading();
      final Position? position = await _getCurrentPosition();
      final Placemark? place = await _getAddressFromLatLng(position!);
      state = AsyncValue.data(AddressState(
        placemark: place,
      ));
      return place;
    } catch (e) {
      state = AsyncValue.error(
          convertToAppException(
            title: 'OOPS!',
            exception: e.toString(),
          ),
          StackTrace.current);
      return null;
    }
  }

  Future<Address?> addressValidator({
    required String shopName,
    required String stateName,
    required String city,
    required String locality,
    required String pinCode,
    required String street,
    required String buildingNumber,
  }) async {
    final userGivenAddress =
        '$buildingNumber/$street/$locality/$city/$stateName/$pinCode/${state.asData?.value.placemark?.country}';
    final finalPlace = await _getLatLngFromAddress(userGivenAddress);
    if (finalPlace != null) {
      return Address(
          stateName: stateName,
          city: city,
          locality: locality,
          pinCode: pinCode,
          street: street,
          buildingNumber: buildingNumber);
    }
    return null;
  }

  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      state = AsyncValue.error(
          convertToAppException(
            title: 'OOPS!',
            exception: e.toString(),
          ),
          StackTrace.current);
      return null;
    }
  }

  Future<Placemark?> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      return place;
    } catch (e) {
      state = AsyncValue.error(
          convertToAppException(
            title: 'OOPS!',
            exception: e.toString(),
          ),
          StackTrace.current);
      return null;
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //print('Location services are disabled. Please enable the services');
      state = AsyncValue.error(
          convertToAppException(
            title: 'Location services',
            exception:
                'Location services are disabled. Please enable the services!',
          ),
          StackTrace.current);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //print('Location permissions are denied');
        state = AsyncValue.error(
            convertToAppException(
              title: 'Location services',
              exception: 'Location permissions are denied',
            ),
            StackTrace.current);

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      //print(
          // 'Location permissions are permanently denied, we cannot request permissions.');
      state = AsyncValue.error(
          convertToAppException(
            title: 'Location services',
            exception:
                'Location permissions are permanently denied, we cannot request permissions.',
          ),
          StackTrace.current);

      return false;
    }
    return true;
  }

  Future<String?> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      Location location = locations[0];
      if (location.toString().isNotEmpty) {
        return address;
      } else {
        state = AsyncValue.error(
            convertToAppException(
              title: 'OOPS!',
              exception: 'Address is invalid!',
            ),
            StackTrace.current);
        return null;
      }
    } catch (e) {
      state = AsyncValue.error(
          convertToAppException(
            title: 'OOPS!',
            exception: e.toString(),
          ),
          StackTrace.current);
      return null;
    }
  }
}

@freezed
abstract class AddressState with _$AddressState {
  const factory AddressState({
    String? address,
    Placemark? placemark,
  }) = _AddressState;
}
