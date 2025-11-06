library system_assets;

// Push data
export 'push_data.dart';

import 'icon_x.dart';

class sysImages {
  // basic impotent paths
  static const basePath = 'assets';
  static const imagesPath = '$basePath/images';
  static const svgPath = '$imagesPath/svg';
  static const pkg = 'system_assets';
  // icons and images
  static const MMlogo = IconX('$imagesPath/management_logo.png', package: pkg);
  static const MOlogo = IconX('$imagesPath/orders_logo.png', package: pkg);
  static const info = IconX('$imagesPath/info.png', package: pkg);
  static const loadingGIF = IconX('$imagesPath/loading.gif', package: pkg);
  static const imagePlaceHolder =
      IconX('$imagesPath/img_placeholder.png', package: pkg);
  static const noInternet = IconX('$imagesPath/no_internet.png', package: pkg);
  static const profile = IconX('$svgPath/profile.svg', package: pkg);
  static const shopEnroll = IconX('$svgPath/shop_enroll.svg', package: pkg);
  static const userEnroll = IconX('$svgPath/user_enroll.svg', package: pkg);
  static const createPIN = IconX('$svgPath/create_pin.svg', package: pkg);
  static const processing = IconX('$svgPath/processing.svg', package: pkg);
  static const noConnection = IconX('$svgPath/no_connection.svg', package: pkg);
  static const internalError =
      IconX('$svgPath/internal_error.svg', package: pkg);
  static const smartBasket = IconX('$svgPath/smart_basket.svg', package: pkg);
  static const emptySearch = IconX('$svgPath/empty_search.svg', package: pkg);
  static const welcome = IconX('$svgPath/welcome.svg', package: pkg);
  static const relaxation = IconX('$svgPath/relaxation.svg', package: pkg);
  static const warning = IconX('$svgPath/warning.svg', package: pkg);
  static const selfie = IconX('$svgPath/selfie.svg', package: pkg);
  static const upload = IconX('$svgPath/upload.svg', package: pkg);
  static const forgotPassword =
      IconX('$svgPath/forgot_password.svg', package: pkg);
  static const enterPassword =
      IconX('$svgPath/enter_password.svg', package: pkg);
  // static const comingSoon = IconX('$svgPath/coming_soon.svg', package: pkg);
  static const deleteAccount =
      IconX('$svgPath/delete_account.svg', package: pkg);
  static const sectionBuilder =
      IconX('$svgPath/section_builder.svg', package: pkg);
  static const mainOrder = IconX('$svgPath/main_order.svg', package: pkg);
  static const actualDelivery =
      IconX('$svgPath/actual_delivery.svg', package: pkg);

  // External images : This image paths are directing to local assets present in apps
  // Why we are using is to provide path to FadeInImageX widget which want local asset path for placeholder
  // But you can use this images like normal images.
  static const imagePlaceHolderX = IconX('$basePath/img_placeholder.png');
  static const loadingGifX = IconX('$basePath/loading.gif');
}
