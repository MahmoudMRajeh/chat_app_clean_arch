
import 'package:chat/core/utils/app_strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class LocalDataSource {
  Future<String>? getStoredUser();
  Future<bool> setCacheUser({required String uid});
  Future<bool> removeLocalUser();
  Future<XFile?> pickImage();
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences prefs;

  LocalDataSourceImpl({required this.prefs});

  @override
  Future<String>? getStoredUser() {
    final uid = prefs.getString(AppStrings.uid);
    if (uid != null) {
      return Future.value(uid);
    }
    return null;
  }

  @override
  Future<bool> setCacheUser({required String uid}) async {
    return await prefs.setString(AppStrings.uid, uid);
  }

  @override
  Future<bool> removeLocalUser() async {
    return await prefs.remove(AppStrings.uid);
  }

  @override
  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
