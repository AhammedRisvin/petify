// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../utils/app_router.dart';
import '../../../utils/enums.dart';
import '../../../utils/loading_overlay.dart';
import '../model/get_blogs_model.dart';

class BlogProvider extends ChangeNotifier {
  String selectedTabBlog = 'All';
  selectedTabBlogFn(String value) {
    selectedTabBlog = value;
    notifyListeners();
  }

  String blogSelectedDateString = '';
  Future<void> blogSelectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      blogSelectedDateString = DateFormat.yMMMd().format(picked);
      notifyListeners();
    }
  }

  TextEditingController blogTitleTextEditingController =
      TextEditingController();
  TextEditingController blogTextEditingController = TextEditingController();

  // image picker
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
    } finally {
      notifyListeners();
    }
  }

  // Image Upload Function
  String imageUrlForUpload = '';

  Future<void> uploadImage() async {
    File? tempImage = await pickImageFromGallery();
    if (tempImage == null) {
      return;
    }

    final fileType = getMimeType(tempImage.path);
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage.path,
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);
        imageUrlForUpload = data["images"][0]["imageUrl"];
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
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
  // CREATE BLOG START

  Future createBlogFn({required BuildContext context}) async {
    if (blogTitleTextEditingController.text.isEmpty ||
        blogTitleTextEditingController.text.isEmpty ||
        blogSelectedDateString == "" ||
        imageTitle?.isEmpty == true) {
      toast(
        context,
        title: 'Please provide all data',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        LoadingOverlay.of(context).show();
        List response = await ServerClient.post(
          Urls.addBlogUrl,
          data: {
            "blogImage": imageUrlForUpload,
            "title": blogTitleTextEditingController.text,
            "blog": blogTextEditingController.text,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          blogTitleTextEditingController.clear();
          blogTextEditingController.clear();
          blogImagePath = '';
          imageUrlForUpload = "";
          imageTitle = null;
          getBlogFn(filter: "all");
          Routes.back(context: context);
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last["message"], backgroundColor: Colors.green);
        } else {
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last["message"], backgroundColor: Colors.red);
          throw Exception('Failed to fetch posts');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
      } finally {
        notifyListeners();
      }
    }
  }
  // CREATE BLOG END

  // GET BLOG START

  GetBlogsModel blogModel = GetBlogsModel();

  GetBlogStatus getBlogStatus = GetBlogStatus.initial;

  Future getBlogFn({required String filter}) async {
    try {
      getBlogStatus = GetBlogStatus.loading;
      List response = await ServerClient.get(
        Urls.getBlogUrl + filter,
      );
      if (response.first >= 200 && response.first < 300) {
        blogModel = GetBlogsModel.fromJson(response.last);
        getBlogStatus = GetBlogStatus.loaded;
      } else {
        getBlogStatus = GetBlogStatus.error;
        blogModel = GetBlogsModel();
      }
    } catch (e) {
      blogModel = GetBlogsModel();
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }
  // GET BLOG END

  // GET SINGLE BLOG DETAILS START
  BlogData? singleBlogData;

  updateSingleBlogData(BlogData? singleBlog) {
    singleBlogData = singleBlog;
    addBlogView(blogId: singleBlogData?.id ?? '');

    notifyListeners();
  }

  // GET SINGLE BLOG DETAILS END

  // Date into TODAY OR YESTERDAY OR DATE START

  String formatDate(DateTime date) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  // Date into TODAY OR YESTERDAY OR DATE END

  // ADD VIEW BLOG START

  Future addBlogView({required String blogId}) async {
    try {
      // LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        "https://test.api.ecom.theowpc.com/user/addView",
        data: {
          "blogId": blogId,
        },
      );
      debugPrint('response: $response');
    } finally {
      notifyListeners();
    }
  }
  //  ADD VIEW BLOG END
}
