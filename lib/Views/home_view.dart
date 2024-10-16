import 'package:code/Components/loading_indicator.dart';
import 'package:code/Components/navigation_bar.dart';
import 'package:code/Models/pharmacy_object.dart';
import 'package:code/Provider/request_provider.dart';
import 'package:code/Services/http_requests.dart';
import 'package:code/Utils/fake_data.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/home_view_model.dart';
import 'package:code/View%20Models/itinerary_view_model.dart';
import 'package:code/View%20Models/map_view_model.dart';
import 'package:code/Views/itinerary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    HomeVM.scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestProvider(),
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        key: HomeVM.scaffoldMessengerKey,
        body: SafeArea(
          child: Consumer<RequestProvider>(
            builder: (context, requestNotifier, child) {
              if (requestNotifier.pharmaAcceptList.isNotEmpty) {
                List<PharmacyObj> pharmas = requestNotifier.pharmaAcceptList;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext modalContext) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              "These pharmacies have what you need",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          for (var pharma in pharmas)
                            ListTile(
                              title: Text(
                                pharma.label,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  color: Palette.mainColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                pharma.address,
                                style: TextStyle(
                                    color: Palette.secoundaryText,
                                    fontSize: 14.sp),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "0.9 km",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    "900 DA",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Palette.secoundaryText,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                log("Picked: ${pharma.label}");
                                requestNotifier.setPharmacy(
                                  pharma,
                                );
                                Navigator.pop(modalContext);
                              },
                            ),
                        ],
                      );
                    },
                  ).whenComplete(() async {
                    String perscriptionId =
                        requestNotifier.perscriptionId ?? "";
                    /* try {
                      log("Delete perscription: ");
                      var reponse = await HttpRequests.deletePerscription(
                          FakeData.userInfo["uid"].toString(), perscriptionId);
                      log(reponse.toString());
                    } catch (e) {
                      log("Somethings wrong with the perscription id.");
                    } */
                    requestNotifier.clearPharmaList();
                    if (requestNotifier.selectedPharmacy != null) {
                      log("ItineraryVM.getItinerary: ");
                      var response = await ItineraryVM.getItinerary(
                        context,
                        start: MapVM.currentLocation,
                        pharma: requestNotifier.selectedPharmacy!,
                        perscriptionId: perscriptionId,
                      );
                      log(response.toString());
                    }

                    if (requestNotifier.getItinerary != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItineraryView(
                            itinerary: requestNotifier.getItinerary!,
                            perscriptionId: perscriptionId,
                            pharmaId:
                                requestNotifier.selectedPharmacy!.pharmaId,
                          ),
                        ),
                      );
                    }
                  });
                });
              }
              bool loading = requestNotifier.isLoading;
              return Stack(
                children: [
                  IgnorePointer(
                    ignoring: loading,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 75.h),
                      child: PageView.builder(
                          itemCount: HomeVM.pagesList.length,
                          controller: HomeVM.pageController,
                          onPageChanged: (value) => setState(() {
                                HomeVM.pageIndex = value;
                              }),
                          itemBuilder: (context, index) {
                            return HomeVM.pagesList[index];
                          }),
                    ),
                  ),
                  AnimatedSlide(
                    offset: loading ? Offset(0, -(120.h)) : const Offset(0, 0),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomNavigationBar(
                          selectedIndex: HomeVM.pageIndex,
                          animateToPage: HomeVM.animateToPage),
                    ),
                  ),
                  if (loading)
                    Container(
                      color: Colors.black.withOpacity(0.25),
                      child: const Center(
                        child: MyLoadingIndicator(type: 2),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
