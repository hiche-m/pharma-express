import 'package:camera/camera.dart';
import 'package:code/Components/camera_grid.dart';
import 'package:code/Components/camera_modes_menu.dart';
import 'package:code/Components/camera_options_menu.dart';
import 'package:code/Models/camera_option_object.dart';
import 'package:code/Utils/styling.dart';
import 'package:code/View%20Models/camera_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CameraView extends StatefulWidget {
  const CameraView({required this.cameras, super.key});

  final List<CameraDescription> cameras;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    super.initState();
    CameraVM.controller =
        CameraController(widget.cameras[0], ResolutionPreset.max);
    CameraVM.controller.setFlashMode(FlashMode.off);
    CameraVM.controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        CameraVM.isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    CameraVM.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: Stack(
          children: [
            // Camera
            CameraVM.isLoading
                ? const SizedBox()
                : Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: GestureDetector(
                          onTapDown: (details) {
                            print(details);
                          },
                          child: CameraPreview(CameraVM.controller)),
                    ),
                  ),
            // Loading Overlay
            AnimatedOpacity(
              opacity: CameraVM.isLoading ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: 1.sh,
                width: 1.sw,
                color: Palette.backgroundColor.withOpacity(0.75),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Palette.darkMain,
                    strokeWidth: 0.5,
                  ),
                ),
              ),
            ),
            // Menu
            IgnorePointer(
              ignoring: CameraVM.isLoading,
              child: Column(
                children: [
                  // Options
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: Palette.backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: CameraOptions(
                          disabled: CameraVM.isLoading,
                          optionIcons: [
                            CameraOption.fromMap({
                              "icon": const FaIcon(
                                FontAwesomeIcons.xmark,
                                color: Colors.white,
                              ),
                              "highlightColor": CameraVM.optionStatus[0]
                                  ? null
                                  : Colors.white,
                              "onTap": () {
                                setState(() {
                                  CameraVM.optionStatus[0] =
                                      !CameraVM.optionStatus[0];
                                });
                                Navigator.of(context).pop();
                              },
                            }),
                            CameraOption.fromMap({
                              "icon": const FaIcon(
                                FontAwesomeIcons.borderNone,
                                color: Colors.white,
                              ),
                              "highlightColor": CameraVM.optionStatus[1]
                                  ? null
                                  : Colors.white,
                              "onTap": () {
                                setState(() {
                                  CameraVM.optionStatus[1] =
                                      !CameraVM.optionStatus[1];
                                });
                              },
                            }),
                            CameraOption.fromMap({
                              "icon": FaIcon(
                                FontAwesomeIcons.boltLightning,
                                color: CameraVM.isFrontCamera
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.white,
                              ),
                              "highlightColor": CameraVM.optionStatus[2]
                                  ? null
                                  : Colors.white,
                              "onTap": () {
                                setState(() {
                                  CameraVM.toggleFlashlight();
                                  setState(() {});
                                });
                              },
                              "disabled": CameraVM.isFrontCamera,
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Capture Frame
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.r, 20.r, 10.r, 20.r),
                      child: CameraVM.optionStatus[1]
                          ? CameraGrid(
                              color: Colors.black.withOpacity(0.25),
                              width: 0.5,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Palette.backgroundColor,
                      child: Column(
                        children: [
                          // Action Modes
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: CameraModes(
                                disabled: CameraVM.isLoading,
                                options: const [
                                  "Ordonnance",
                                  "Produit",
                                  "Code QR"
                                ],
                              ),
                            ),
                          ),
                          // Bottom Actions
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.r, 20.r, 10.r, 10.r),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    color: CameraVM.isLoading
                                        ? Palette.mainColor.withAlpha(50)
                                        : Palette.mainColor,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: CameraVM.capturedImage != null
                                              ? () =>
                                                  CameraVM.previewImage(context)
                                              : null,
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9999.r),
                                          ),
                                          child: Ink(
                                            height: (40 * 2).r,
                                            width: (40 * 2).r,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              borderRadius:
                                                  BorderRadius.circular(9999),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(5.r),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(9999),
                                                child: CameraVM.capturedImage !=
                                                        null
                                                    ? Hero(
                                                        tag: "captured_picture",
                                                        child: Image.file(
                                                          CameraVM
                                                              .capturedImage!,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9999.r),
                                          ),
                                          splashColor:
                                              Colors.black.withOpacity(0.1),
                                          highlightColor:
                                              Colors.black.withOpacity(0.1),
                                          focusColor:
                                              Colors.black.withOpacity(0.1),
                                          onTap: () async {
                                            setState(() {
                                              CameraVM.isLoading = true;
                                            });
                                            await CameraVM.capturePicture();
                                            setState(() {
                                              CameraVM.isLoading = false;
                                            });
                                            CameraVM.previewImage(context);
                                          },
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(9999.r),
                                            ),
                                            child: SizedBox(
                                                height: (50 * 2).r,
                                                width: (50 * 2).r),
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              CameraVM.isLoading = true;
                                            });
                                            await CameraVM.switchCamera(
                                                widget.cameras);
                                            if (mounted) {
                                              setState(() {
                                                CameraVM.isLoading = false;
                                              });
                                            }
                                          },
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9999.r),
                                          ),
                                          child: Ink(
                                            height: (40 * 2).r,
                                            width: (40 * 2).r,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              borderRadius:
                                                  BorderRadius.circular(9999),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(5.r),
                                                child: FaIcon(
                                                    FontAwesomeIcons.rotate,
                                                    color: Colors.white,
                                                    size: 30.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
