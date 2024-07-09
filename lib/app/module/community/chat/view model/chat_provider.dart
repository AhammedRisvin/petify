// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/loading_overlay.dart';

class ChatProvider extends ChangeNotifier {
  List<File> petDocumentFiles = [];
  String picked = '';

  void pickChatMedia(
      {required BuildContext context, required Null Function() onTap}) async {
    try {
      List<PlatformFile> petDocumentList = [];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          "png",
          "jpeg",
          'pdf',
          'mp4',
          'mkv',
        ],
      );
      petDocumentList.addAll(result?.files ?? []);
      // result?.files[0];
      if (petDocumentList.isEmpty) return;
      petDocumentFiles.clear();
      for (var element in petDocumentList) {
        final imageTemporaryData = File(element.path!);
        petDocumentFiles.add(imageTemporaryData);
      }
      picked = petDocumentFiles.first.path;
      if (picked.isNotEmpty) {
        onTap();
      }
    } finally {
      notifyListeners();
    }
  }

//upload document to aws
  List<String> uploadedPetDocumentUrls = [];
  String imageUrlForUpload = '';

  Future<void> uploadFile(
      {required BuildContext context,
      required Function(String? url, String? ext) onTap}) async {
    if (petDocumentFiles.isEmpty) {
      return;
    }

    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Add images to the request
    for (var i = 0; i < petDocumentFiles.length; i++) {
      final fileType = getMimeType(petDocumentFiles[i].path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'image_mushthak',
          petDocumentFiles[i].path,
          contentType: MediaType.parse(fileType),
        ),
      );
      request.headers['Content-Type'] = fileType;
    }

    try {
      LoadingOverlay.of(context).show();
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        debugPrint('Image uploaded successfully with response: $responseBody');
        String imageUrl = jsonResponse['images'][0]['imageUrl'];
        String ext = imageUrl.split('.').last;
        onTap(imageUrl, ext);
      } else {
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  String getMimeType(String filePath) {
    final file = File(filePath);
    final fileType = file.path.split('.').last.toLowerCase();
    switch (fileType) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'mov':
        return 'video/quicktime';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'flac':
        return 'audio/flac';
      default:
        return 'application/octet-stream';
    }
  }

  String formatTime(DateTime time) {
    // Extract hour and minute from the DateTime object
    int hour = time.hour > 12 ? time.hour - 12 : time.hour;
    String hourString = hour.toString();
    String minuteString = time.minute.toString().padLeft(2, '0');

    // Determine AM or PM
    String period = time.hour >= 12 ? 'PM' : 'AM';

    // Concatenate the strings
    String formattedTime = "$hourString.$minuteString $period";
    return formattedTime;
  }

  Future<void> launchPDF(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String formatNumber(int value) {
    if (value >= 1000) {
      double dividedValue = value / 1000.0;
      return '${dividedValue.toStringAsFixed(2)}  k';
    } else {
      return value.toString();
    }
  }

  String formatDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    // If the date is today
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat.jm()
          .format(dateTime); // Time only in 12hr format with AM/PM
    }
    // If the date is yesterday
    else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return 'Yesterday ${DateFormat.jm().format(dateTime)}'; // Yesterday and time in 12hr format
    }
    // If the date is past yesterday
    else {
      return DateFormat('dd/MM hh:mm a')
          .format(dateTime); // Day/Month and time in 12hr format with AM/PM
    }
  }
}
