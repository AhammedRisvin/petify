// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:clan_of_pets/app/utils/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_router.dart';

class CreateCommunityProvider extends ChangeNotifier {
  File? thumbnailImage;
  String? imageTitle;
  String blogImagePath = '';
  Future<File?> pickImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      var image = result?.files[0];
      if (image == null) return null;
      final imageTemporaryData = File(image.path!);
      thumbnailImage = imageTemporaryData;
      blogImagePath = thumbnailImage?.path ?? "";
      imageTitle = thumbnailImage?.path.split('/').last;
      return imageTemporaryData;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
    }
  }

  String singleImageUr = '';

  String? imageTitlee;
  Future<void> uploadSingleImage(BuildContext context) async {
    File? tempImage = await pickImageFromGallery();
    imageTitlee = tempImage?.path.split('/').last;
    final fileType = getMimeType(tempImage?.path ?? '');
    LoadingOverlay.of(context).show();
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage?.path ?? '',
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);
        singleImageUr = data["images"][0]["imageUrl"];
      }
    } finally {
      notifyListeners();
      LoadingOverlay.of(context).hide();
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

  TextEditingController communityNamerController = TextEditingController();

  TextEditingController communityDescriptionController =
      TextEditingController();

  Future createCommunityFn({required BuildContext context}) async {
    try {
      List response = await ServerClient.post(
        Urls.createCommunityUrl,
        data: {
          "groupName": communityNamerController.text,
          "groupDescription": communityDescriptionController.text,
          "groupProfileImage": singleImageUr,
          "groupCoverImage": coverImageUr
        },
      );
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        communityNamerController.clear();
        communityDescriptionController.clear();
        singleImageUr = '';
        coverImageUr = '';
        imageTitle = null;
        coverImageTitle = null;
        thumbnailImage = null;
        Routes.back(context: context);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  String coverImageUr = '';

  String? coverImageTitle;
  Future<void> uploadCoverImage(BuildContext context) async {
    File? tempImage = await pickImageFromGallery();
    coverImageTitle = tempImage?.path.split('/').last;
    LoadingOverlay.of(context).show();
    final fileType = getMimeType(tempImage?.path ?? '');
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage?.path ?? '',
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);
        coverImageUr = data["images"][0]["imageUrl"];
      }
    } finally {
      notifyListeners();
      LoadingOverlay.of(context).hide();
    }
  }
}
