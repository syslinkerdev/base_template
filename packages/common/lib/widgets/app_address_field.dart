import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class AppAddressField extends HookConsumerWidget {
  const AppAddressField({super.key, this.action, this.address, this.onChange});

  final Address? address;
  final List<Widget>? Function({Address? address})? action;
  final Function(Address address)? onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle? labelAndHintStyle = TextStyles.h10Bold(context);
    final addressWat = ref.watch(addressManagerProvider);
    final stateNameController = useTextEditingController(text: '');
    final cityNameController = useTextEditingController(text: '');
    final localityNameController = useTextEditingController(text: '');
    final pinCodeNameController = useTextEditingController(text: '');
    final streetNameController = useTextEditingController(text: '');
    final shopMainBuildingNameController = useTextEditingController(text: '');

    final addressNotifier = useState(Address.empty());

    void notifyAddressChange() {
      final updatedAddress = Address(
        stateName: stateNameController.text,
        city: cityNameController.text,
        locality: localityNameController.text,
        pinCode: pinCodeNameController.text,
        street: streetNameController.text,
        buildingNumber: shopMainBuildingNameController.text,
      );
      if (action != null) {
        addressNotifier.value = updatedAddress;
      }
      if (onChange != null) {
        onChange?.call(updatedAddress);
      }
    }

    void addListenerToControllers() {
      stateNameController.addListener(notifyAddressChange);
      cityNameController.addListener(notifyAddressChange);
      localityNameController.addListener(notifyAddressChange);
      pinCodeNameController.addListener(notifyAddressChange);
      streetNameController.addListener(notifyAddressChange);
      shopMainBuildingNameController.addListener(notifyAddressChange);
    }

    void removeListenerFromControllers() {
      stateNameController.removeListener(notifyAddressChange);
      cityNameController.removeListener(notifyAddressChange);
      localityNameController.removeListener(notifyAddressChange);
      pinCodeNameController.removeListener(notifyAddressChange);
      streetNameController.removeListener(notifyAddressChange);
      shopMainBuildingNameController.removeListener(notifyAddressChange);
    }

    ref.listen(
      addressManagerProvider,
      (_, next) {
        next.showAlertDialogOnError(
          context,
        );
        next.maybeWhen(
          orElse: () {},
          data: (data) => showMessageSnackbar(
              context: context, message: 'Your Current Location Updated!'),
        );
      },
    );

    void updateAddress({Placemark? place, Address? adrs}) {
      removeListenerFromControllers();
      if (adrs != null) {
        stateNameController.text = adrs.stateName;
        cityNameController.text = adrs.city;
        localityNameController.text = adrs.locality;
        pinCodeNameController.text = adrs.pinCode;
        streetNameController.text = adrs.street;
        shopMainBuildingNameController.text = adrs.buildingNumber;
      } else {
        stateNameController.text = place?.administrativeArea ?? '';
        cityNameController.text = place?.locality ?? '';
        localityNameController.text = place?.subLocality ?? '';
        pinCodeNameController.text = place?.postalCode ?? '';
        streetNameController.text =
            place?.street != place?.name ? place?.street ?? '' : '';
        shopMainBuildingNameController.text = place?.name ?? '';
      }
      addListenerToControllers();
      notifyAddressChange();
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (address != null) {
          updateAddress(adrs: address);
        } else {
          final result =
              await ref.read(addressManagerProvider.notifier).getPlace();
          updateAddress(place: result);
        }
      });
      return null;
    }, []);

    useEffect(() {
      addListenerToControllers();
      return () => removeListenerFromControllers();
    }, []);

    return Column(
      children: [
        gapH8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CaptionText(title: 'Address', isRequired: false),
            IconButton(
              onPressed: () async {
                final place =
                    await ref.read(addressManagerProvider.notifier).getPlace();
                updateAddress(place: place);
              },
              icon: addressWat.maybeWhen(
                orElse: () => const SizedBox(),
                skipError: true,
                loading: () => SpinKitDoubleBounce(
                    color: appColors.ms.black(context),
                    size: context.sizeOfHeight * 0.03),
                data: (place) => Icon(Icons.location_searching_rounded,
                    color: appColors.cS(context).onPrimaryFixedVariant),
              ),
              tooltip: 'current location',
            ),
          ],
        ),
        Structure(
            firstChild: AppTextField(
              inputType: TextInputType.streetAddress,
              controller: stateNameController,
              hintText: 'State',
              labelText: 'State',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            ),
            secondChild: AppTextField(
              inputType: TextInputType.streetAddress,
              controller: cityNameController,
              hintText: 'City/Town',
              labelText: 'City/Town',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            )),
        gapH8,
        Structure(
            firstChild: AppTextField(
              inputType: TextInputType.streetAddress,
              controller: localityNameController,
              hintText: 'Locality',
              labelText: 'Locality',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            ),
            secondChild: AppTextField(
              controller: pinCodeNameController,
              inputType: TextInputType.number,
              hintText: 'code',
              labelText: 'PIN code',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            )),
        gapH8,
        Structure(
            firstFlex: 2,
            firstChild: AppTextField(
              inputType: TextInputType.streetAddress,
              controller: streetNameController,
              hintText: 'area/street',
              labelText: 'Village/Area/Street',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            ),
            secondChild: AppTextField(
              inputType: TextInputType.streetAddress,
              controller: shopMainBuildingNameController,
              hintText: 'Shop number',
              labelText: 'Name',
              contentPaddingVertical: 0,
              contentPaddingHorizontal: 8,
              labelAndHintStyle: labelAndHintStyle,
            )),
        if (action != null) ...?action!(address: addressNotifier.value),
      ],
    );
  }
}

class Structure extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final int firstFlex;
  final int secondFlex;

  const Structure({
    super.key,
    required this.firstChild,
    required this.secondChild,
    this.firstFlex = 1,
    this.secondFlex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: firstFlex,
          child: firstChild,
        ),
        gapW4,
        Flexible(
          flex: secondFlex,
          child: secondChild,
        ),
      ],
    );
  }
}
