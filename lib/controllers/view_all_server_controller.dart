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
  List<ViewAllServerData> _allServerList = [];
  List<ViewAllServerData>? _newServerList;
  int _page = 1;


  /// Getter
  bool get isLoading => _isLoading;
  ViewAllServerResponseModel? get viewAllServerResponseModel => _viewAllServerResponseModel;
  List<ViewAllServerData> get allServerList => _allServerList;
  List<ViewAllServerData>? get newServerList => _newServerList;
  int get page => _page;


  /// For All Products pagination

  /// For Reset Page
  void resetPage() {
    _page = 1;
    update();
  }

  /// For Page Counter
  void pageCounter({required BuildContext context}) {
    ++_page;
    update();
  }

  /// For Clear List
  void clearList(){
    _allServerList.clear();
    update();
  }


  /// For get all products data
  Future<List<ViewAllServerData>?> getAllServerData({required BuildContext context, dynamic pageNo}) async {

    _isLoading = true;
    update();

    ApiResponse apiResponse = await viewAllServerRepo.getAllServerData(page: pageNo.toString());

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _isLoading = false;
      _viewAllServerResponseModel = null;
      _newServerList = null;

      _viewAllServerResponseModel = ViewAllServerResponseModel.fromJson(apiResponse.response!.data);
      _newServerList = _viewAllServerResponseModel!.allServerList;
      _allServerList = _allServerList + _newServerList!;

      update();
    } else {
      _isLoading = false;
      update();
    }
    return _allServerList;
  }


}