import 'package:cached_network_image/cached_network_image.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/update_admin_profile_controller.dart';
import 'package:eye_vpn_lite_admin_panel/controllers/view_all_server_controller.dart';
import 'package:eye_vpn_lite_admin_panel/utils/app_color_resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../controllers/admin_profile_controller.dart';
import '../../../controllers/server_delete_controller.dart';
import '../../../utils/app_style.dart';
import '../../widgets/logout_alert_dialogue.dart';
import '../../widgets/reusable_delete_alert_dialogue.dart';
import '../../widgets/reusable_divider.dart';
import '../responsive/responsive.dart';
import '../server/add_server_screen.dart';
import '../server/edit_server_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController scrollController = ScrollController();
  final serverDeleteController = Get.find<ServerDeleteController>();
  final updateAdminProfileController = Get.find<UpdateAdminProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ViewAllServerController>().resetPage();
      Get.find<ViewAllServerController>().clearList();
      final page = Get.find<ViewAllServerController>().page;
      _load(reLoad: true, context: context, pageNo: page.toString());
      scrollController.addListener(_scrollListener);
    });
  }

  /// For Scroll Listener
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      Get.find<ViewAllServerController>().pageCounter(context: context);
      final page = Get.find<ViewAllServerController>().page;
      _load(reLoad: true, context: context, pageNo: page.toString());
      if (kDebugMode) {
        print("scrolling");
      }
    }
  }

  /// For Load Data
  _load({required bool reLoad, required BuildContext context, required dynamic pageNo}) async{
    await Get.find<ViewAllServerController>().getAllServerData(context: context, pageNo: pageNo.toString(), paginate: 25);
    await Get.find<AdminProfileController>().getAdminProfile(context: context);
  }

  /// For password star format
  String maskPassword(String password) {
    return '*' * password.length;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColorResources.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColorResources.primaryColor,
        title: Text("Admin Dashboard", style: myStyleOxanium(
            ResponsiveUI.isDesktop(context)?18:16,
            AppColorResources.primaryWhite,
            FontWeight.w600),
        ),
        actions: [
          Icon(Icons.person_outline_outlined, size: ResponsiveUI.isDesktop(context)?30:20, color: AppColorResources.primaryGreen,),
          SizedBox(width: 10,),
          GetBuilder<AdminProfileController>(
            builder: (adminProfileController) {
              return adminProfileController.adminProfileResponseModel != null?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${adminProfileController.adminProfileResponseModel!.name}", style: myStyleOxanium(
                      ResponsiveUI.isDesktop(context)?15:13,
                      AppColorResources.primaryWhite,
                      FontWeight.w600),
                  ),
                  Text("${adminProfileController.adminProfileResponseModel!.email}", style: myStyleOxanium(
                      ResponsiveUI.isDesktop(context)?14:12,
                      AppColorResources.primaryWhite,
                      FontWeight.w600),
                  ),
                ],
              ):Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                period: const Duration(milliseconds: 2000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 100,
                      color: AppColorResources.primaryWhite,
                    ),
                    SizedBox(height: 3,),
                    Container(
                      height: 10,
                      width: 100,
                      color: AppColorResources.primaryWhite,
                    ),
                  ],
                ),
              );
            }
          ),

          SizedBox(width: 10,),

          /// For Log out
          GestureDetector(
              onTap: (){
                logoutAlert(context);
              },
              child: Icon(Icons.power_settings_new_outlined, size: ResponsiveUI.isDesktop(context)?30:20, color: AppColorResources.primaryRed,)),

          SizedBox(width: 12,),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ViewAllServerController>(
          builder: (viewAllServerController) {
            return Container(
              padding: EdgeInsets.all(15),
              child: Stack(
                children: [
                  SizedBox(height: 15,),

                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "All Servers",
                              style: myStyleOxanium(
                                  17,
                                  AppColorResources.primaryWhite,
                                  FontWeight.w600),
                            ),

                            GestureDetector(
                              onTap: (){
                                Get.toNamed(CreateServerScreen.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColorResources.primaryGreen,
                                ),
                                child: Text(
                                  "+ Add New",
                                  style: myStyleOxanium(
                                      15,
                                      AppColorResources.primaryWhite,
                                      FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 15,),

                        /// Table Header
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColorResources.tableHeaderColorGreen,
                          ),
                          child: Row(
                            children: [
                              /// Server Name
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Server Name",
                                    style: myStyleOxanium(
                                        16,
                                        AppColorResources.primaryBlack,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),

                              /// Country
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Country",
                                    style: myStyleOxanium(
                                        16,
                                        AppColorResources.primaryBlack,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),

                              /// Username
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Username",
                                    style: myStyleOxanium(
                                        16,
                                        AppColorResources.primaryBlack,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),

                              /// Password
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text("Password",
                                    style: myStyleOxanium(16, AppColorResources.primaryBlack, FontWeight.w600),
                                  ),
                                ),
                              ),

                              /// Protocol
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Protocol",
                                    style: myStyleOxanium(16, AppColorResources.primaryBlack, FontWeight.w600),
                                  ),
                                ),
                              ),

                              /// Action
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  //color: AppColorResources.switchColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Action",
                                    style: myStyleOxanium(16, AppColorResources.primaryBlack, FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        reusableDivider(),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 112),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        /// Table Body
                        Container(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox.shrink(),
                            itemCount: viewAllServerController.allServerList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index < viewAllServerController.allServerList.length) {
                                final item = viewAllServerController.allServerList.reversed.toList()[index];
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: index % 2 == 0 ? AppColorResources.oddColor : AppColorResources.secondaryGreenAccent,
                                      ),
                                      child: Row(
                                        children: [

                                          /// Server Name
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 15),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 25,
                                                    width: 35,
                                                    child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: CachedNetworkImage(
                                                          imageUrl: "${item.image}",
                                                          placeholder: (context, url) => Opacity(
                                                            opacity: 0.8,
                                                            child: Shimmer.fromColors(
                                                                baseColor: AppColorResources.drawerItemColor,
                                                                highlightColor: AppColorResources.primaryWhite,
                                                                direction: ShimmerDirection.ltr,
                                                                child: const SizedBox(
                                                                  height: 25,
                                                                  width: 35,
                                                                )),
                                                          ),
                                                          errorWidget: (context, url, error) => Container(
                                                              height: 25,
                                                              width: 35,
                                                              child: Icon(Icons.image_outlined, color: AppColorResources.primaryColor)),
                                                        ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 8,),
                                                  Text("${item.country}", style: myStyleOxanium(15, AppColorResources.primaryBlack, FontWeight.w400),),
                                                ],
                                              ),
                                            ),
                                          ),

                                          /// Country
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              child: Text("${item.country}", style: myStyleOxanium(15, AppColorResources.primaryBlack, FontWeight.w400),),
                                            ),
                                          ),

                                          /// Username
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              child: Text("${item.username}", style: myStyleOxanium(15, AppColorResources.primaryBlack, FontWeight.w400),),
                                            ),
                                          ),

                                          /// Password
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              child: Text("${maskPassword(item.password)}", style: myStyleOxanium(15, AppColorResources.primaryBlack, FontWeight.w400),),
                                            ),
                                          ),

                                          /// Protocol
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              //color: AppColorResources.secondaryGreenAccent,
                                              alignment: Alignment.center,
                                              child: Text("${item.config}", style: myStyleOxanium(15, AppColorResources.primaryBlack, FontWeight.w400),
                                                maxLines: 2,
                                                textAlign: TextAlign.justify,),
                                            ),
                                          ),

                                          /// Edit and Delete Button
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    /// For Edit
                                                    InkWell(
                                                      onTap: (){
                                                        Get.toNamed(EditServerScreen.routeName, arguments: item.id);
                                                      },
                                                      child: Container(
                                                        height: ResponsiveUI.isDesktop(context) ? 30 : 24,
                                                        width: ResponsiveUI.isDesktop(context) ? 30 : 24,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: AppColorResources.primaryGreen),
                                                        child: Icon(Icons.edit, size: 15, color: AppColorResources.primaryWhite,),
                                                      ),
                                                    ),

                                                    SizedBox(width: 8,),

                                                    /// Delete
                                                    InkWell(
                                                      onTap: (){
                                                        reusableDeleteAlertDialogue(context, deleteItemName: 'server',
                                                          onTap: () {
                                                          setState(() {
                                                            serverDeleteController.deleteServer(context: context, id: item.id.toString());
                                                          });
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: ResponsiveUI.isDesktop(context) ? 30 : 24,
                                                        width: ResponsiveUI.isDesktop(context) ? 30 : 24,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: AppColorResources.primaryRed),
                                                        child: Icon(Icons.delete_forever_outlined, size: 15, color: AppColorResources.primaryWhite,),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                  ],
                                );
                              }else{
                                return Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text("No Server Found", style: myStyleOxanium(18, AppColorResources.primaryWhite, FontWeight.w500),),
                                  ),
                                );
                              }
                            },
                          ),
                        ),

                        /// For Server List Empty
                        viewAllServerController.isLoading == false && viewAllServerController.allServerList.isEmpty?
                        Center(child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: Text("No Server Found", style: myStyleOxanium(18, AppColorResources.primaryWhite, FontWeight.w500),),
                              ),
                            ],
                          ),
                        ),):SizedBox.shrink(),

                        /// For Getting new server
                        viewAllServerController.isLoading == false?
                        SizedBox() : Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 5),
                                Text("Loading Server...", style: myStyleOxanium(18, AppColorResources.primaryWhite, FontWeight.w500),),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
