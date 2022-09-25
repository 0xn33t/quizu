import 'package:phone_number/phone_number.dart';
import 'package:quiz_u/core/config/index.dart';

class PhoneNumberUtils {
  PhoneNumberUtils({PhoneNumberUtil? plugin})
      : plugin = plugin ?? PhoneNumberUtil();

  final PhoneNumberUtil plugin;

  Future<String> carrierRegionCode() async {
    try {
      return await plugin.carrierRegionCode();
    } catch (e) {
      print(e.toString());
      return Settings.fallbackCarrierRegionCode;
    }
  }

  Future<bool> validate(String string, {String? regionCode}) async {
    try {
      return await plugin.validate(string, regionCode: regionCode);
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<PhoneNumber?> parse(String string, {String? regionCode}) async {
    try {
      return await plugin.parse(string, regionCode: regionCode);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
