import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _box = GetStorage();
  static Future<void> writeStorage(key, value) async {
    await _box.write(key, value);
  }

  static Future<void> removeStorage(key) async {
    await _box.remove(key);
  }

  static Future<void> removeAll() async {
    await _box.erase();
  }

  static Future<String> readStorage(key) async {
    return await _box.read(key);
  }
}
