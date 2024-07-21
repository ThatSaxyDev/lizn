import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:lizn/core/utils/extensions.dart';

//! pick audio
Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'aac', 'wav'],
    );

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

//! pick image
Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg'],
    );

    if (filePickerRes != null) {
      return File(filePickerRes.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    e.log();
    return null;
  }
}

//! convert color to hex
String rgbToHex({required Color color}) {
  return '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

//! hex to color
Color hexToColor({required String hex}) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}
