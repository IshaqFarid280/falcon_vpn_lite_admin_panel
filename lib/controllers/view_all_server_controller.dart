import 'package:eye_vpn_lite_admin_panel/data/repository/view_all_server_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/base_model/api_response.dart';
import '../data/model/response_model/view_all_server_response_model.dart';

class ViewAllServerController extends GetxController{
  final DioClient dioClient;
  final ViewAllServerRepo viewAllServerRepo;

  ViewAllServerController({required this.dioClient, required this.viewAllServerRepo});

  bool _isLoading = false;
  ViewAllServerResponseModel? _viewAllServerResponseModel;
  List<ViewAllServerData>? _allServerList;
  int _page = 1;
  int _paginate = 8;


  /// Getter
  bool get isLoading => _isLoading;
  ViewAllServerResponseModel? get viewAllServerResponseModel => _viewAllServerResponseModel;
  List<ViewAllServerData>? get allServerList => _allServerList;
  int get page => _page;
  int get paginate => _paginate;


  /// For All Products pagination

  /// For Reset Page
  void resetPage() {
    _page = 1;
    _paginate = 8;
    update();
  }

  /// For Page Counter
  void pageCounter({required BuildContext context}) {
    ++_page;
    update();
  }

  /// For Page Counter
  void pageCounterRemove({required BuildContext context}) {
    --_page;
    update();
  }

  /// For Clear List
  // void clearList(){
  //   _allServerList!.clear();
  //   update();
  // }


  /// For get all products data
  Future<List<ViewAllServerData>?> getAllServerData({required BuildContext context, dynamic pageNo, dynamic paginate}) async {

    _isLoading = true;
    update();

    ApiResponse apiResponse = await viewAllServerRepo.getAllServerData(page: pageNo.toString(), paginate: paginate.toString());

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _isLoading = false;
      _viewAllServerResponseModel = null;

      _viewAllServerResponseModel = ViewAllServerResponseModel.fromJson(apiResponse.response!.data);
      _allServerList = _viewAllServerResponseModel!.allServerList;

      update();
    } else {
      _isLoading = false;
      update();
    }
    return _allServerList;
  }


}