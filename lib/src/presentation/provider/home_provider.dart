import 'dart:io';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unsplash/src/core/utils/error_handler.dart';
import 'package:unsplash/src/data/models/unsplash_model.dart';
import 'package:unsplash/src/data/repositories/home_repository.dart';
import 'package:http/http.dart' as http;

@injectable
class HomeProvider extends ChangeNotifier {
  final HomeRepository _homeRepository;

  HomeProvider({required HomeRepository homeRepository})
      : _homeRepository = homeRepository {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getPaginatedImages();
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  List<UnsplashModel> _imageList = [];

  List<UnsplashModel> get imageList => _imageList;

  set insertImages(List<UnsplashModel> images) {
    _imageList.addAll(images);
    notifyListeners();
  }

  set setImage(List<UnsplashModel> images) {
    _imageList = images;
    notifyListeners();
  }

  void resetImageList() {
    _imageList = [];
    notifyListeners();
  }

  int _currentPage = 1;
  int get currentPage => _currentPage;

  set setCurrentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  Failure? _failure;

  Failure? get failure => _failure;

  set setFailure(Failure? error) {
    _failure = error;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _paginationLoading = false;

  bool get paginationLoading => _paginationLoading;

  set setPaginationLoading(bool value) {
    _paginationLoading = value;
    notifyListeners();
  }

  Future<void> getImages() async {
    setLoading = true;
    setCurrentPage = 1;
    resetImageList();
    final res = await _homeRepository.getImages(page: '$currentPage');
    res.fold((error) {
      setFailure = error;
      setLoading = false;
    }, (success) {
      setFailure = null;
      setCurrentPage = _currentPage + 1;
      setImage = success;
      setLoading = false;
      setPaginationLoading = true;
    });
  }

  Future<void> getPaginatedImages() async {
    setPaginationLoading = true;
    final res = await _homeRepository.getImages(page: '$currentPage');
    res.fold((error) {
      setFailure = error;
      setPaginationLoading = false;
    }, (success) {
      setFailure = null;
      setCurrentPage = _currentPage + 1;
      insertImages = success;
    });
  }

  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;

  set setDownloading(bool value) {
    _isDownloading = value;
    notifyListeners();
  }

  bool _downloadFailed = false;
  bool get downloadFailed => _downloadFailed;

  set setDownloadFailed(bool value) {
    _downloadFailed = value;
    notifyListeners();
  }

  Future<void> downloadImage(String url) async {
    try {
      setDownloading = true;
      final res = await http.get(Uri.parse(url));
      final directory = await getTemporaryDirectory();
      final tempPath = directory.path;
      // Split the URL at the '?' to remove query parameters
      final splitUrl = url.split('?');

      // Extract the file name from the first part
      final fileName = splitUrl[0].split('/').last;
      // Create a file path
      final filePath = '$tempPath/$fileName.jpg';

      // Save the image to the file
      final file = File(filePath);
      await file.writeAsBytes(res.bodyBytes);
      await Share.shareXFiles([XFile(file.path)]);
      setDownloading = false;
    } catch (e) {
      setDownloading = false;
      setDownloadFailed = true;
    }
  }
}
