import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rcf_attendance_generator/core/states/ticket_state.dart';
import 'package:screenshot/screenshot.dart';
import '../../widgets/download_ticket/infos_right_widget.dart';
import '../../widgets/download_ticket/form_left_widget.dart';
import 'package:rcf_attendance_generator/app/images.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'controller/download_qr_controller.dart';
import 'package:provider/provider.dart';
import '../../styles/color.dart';

// import '../../../core/repos/download_qr_repo.dart';
// import '../../../core/data/download_qr_datasource.dart';
// import 'package:http/http.dart' as http;

class DownloadQR extends StatefulWidget {
  final String userId;

  const DownloadQR({super.key, required this.userId});

  @override
  State<DownloadQR> createState() => _DownloadQRState();
}

class _DownloadQRState extends State<DownloadQR> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    try {
      await context.read<DownloadQrController>().getProfile(widget.userId);
    } catch (e) {
      print(e);
      // Messenger.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadQrController>(
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: model.state.runtimeType == LoadingTicketState
                    ? const CircularProgressIndicator()
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          return constraints.maxWidth < 600
                              ? SizedBox(
                                  height: constraints.maxHeight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FormLeft(
                                        linearGradient:
                                            AppColors.linearGradient,
                                        constraints: constraints,
                                        controller: model,
                                      ),
                                      Screenshot(
                                        controller: model.screenshotController,
                                        child: InfosRight(
                                          constraints: constraints,
                                          controller: model,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: constraints.maxHeight * 0.5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FormLeft(
                                        linearGradient:
                                            AppColors.linearGradient,
                                        constraints: constraints,
                                        controller: model,
                                      ),
                                      const SizedBox(width: 32),
                                      Screenshot(
                                        controller: model.screenshotController,
                                        child: InfosRight(
                                          constraints: constraints,
                                          controller: model,
                                        ),
                                      ),
                                      // if (model.bytes != null) buildImage(model.bytes!),
                                    ],
                                  ),
                                );
                        },
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
}
