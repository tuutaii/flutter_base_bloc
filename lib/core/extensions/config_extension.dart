import '../config.dart';

extension FlavorExtFromString on String? {
  Flavor get flavor {
    switch (this) {
      case 'dev':
        return Flavor.dev;
      case 'staging':
        return Flavor.staging;
      default:
        return Flavor.prod;
    }
  }
}
