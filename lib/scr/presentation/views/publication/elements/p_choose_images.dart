import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moger_web/scr/configs/app/export.dart';

class PChooseImages extends StatelessWidget {
  PChooseImages(
      {super.key,
      required this.pickedFiles,
      required this.isLoadingImages,
      required this.linkImages});
  var chooseImageCardColor = Rx<Color>(Colors.white);
  late DropzoneViewController controller;
  var isLoadingImages;
  Rx<List<Uint8List>> pickedFiles;
  var linkImages;
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print(linkImages.value.length);
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth > 700.0 ? 700.0 : constraints.maxWidth;

      return ListView(
        physics: const CupertinoScrollBehavior().getScrollPhysics(context),
        controller: scrollController,
        children: [
          24.h,
          const EText(
            "Vos images",
            size: 26,
            weight: FontWeight.bold,
          ),
          const EText(
            "Ajoutez des images attirantes pour faire projeter vos clients",
            maxLines: 4,
          ),
          24.h,
          Obx(
            () => AnimatedSwitcher(
              duration: 666.milliseconds,
              child: /*  pickedFiles.value.isEmpty && linkImages.value.isEmpty
                  ?  */
                  EColumn(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(
                        () => AnimatedContainer(
                          duration: 333.milliseconds,
                          height: 200,
                          width: width - 32,
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: chooseImageCardColor.value,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12)),
                          child: DropzoneView(
                            operation: DragOperation.copy,
                            cursor: CursorType.grab,
                            onCreated: (DropzoneViewController ctrl) =>
                                controller = ctrl,
                            onLoaded: () => print('Zone loaded'),
                            onError: (String? ev) => print('Error: $ev'),
                            onHover: () {
                              chooseImageCardColor.value =
                                  const Color.fromARGB(255, 189, 209, 233);
                            },
                            onDrop: (dynamic ev) async {
                              chooseImageCardColor.value = Colors.white;
                              if (ev.isNul) {
                                return;
                              }

                              final data = await controller.getFileData(ev);
                              if (isImage(data)) {
                                pickedFiles.update((val) {
                                  val?.add(data);
                                });
                              }
                            },
                            onDropMultiple: (List<dynamic>? ev) async {
                              chooseImageCardColor.value = Colors.white;

                              if (ev.isNul) {
                                return;
                              }
                              for (var element in ev!) {
                                final data =
                                    await controller.getFileData(element);
                                if (isImage(data)) {
                                  pickedFiles.update((val) {
                                    val?.add(data);
                                  });
                                }
                              }
                            },
                            onLeave: () {
                              chooseImageCardColor.value = Colors.white;
                            },
                          ),
                        ),
                      ),
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        Image(
                          image: AssetImage(
                            Assets.icons("drop_images.png"),
                          ),
                          height: 75,
                        ),
                        12.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const EText(
                              "Glissez pour déposer ou ",
                              weight: FontWeight.bold,
                            ),
                            TextButton(
                              onPressed: () {
                                ImagePicker()
                                    .pickMultiImage()
                                    .then((value) async {
                                  for (var element in value) {
                                    final data = await element.readAsBytes();
                                    pickedFiles.update((val) {
                                      val?.add(data);
                                    });
                                  }
                                  waitAfter(666, () {
                                    scrollController.animateTo(
                                        scrollController
                                            .position.maxScrollExtent,
                                        duration: 333.milliseconds,
                                        curve: Curves.ease);
                                  });
                                  // pickedFiles.update((val) {
                                  //   val?.addAll(
                                  //       value.map((e) async {
                                  //         print(await e.readAsBytes());
                                  //         return await e.readAsBytes();
                                  //       }));
                                  // });
                                });
                              },
                              child: EText("Selectionnez",
                                  underline: true,
                                  color: AppColors.blue,
                                  weight: FontWeight.bold),
                            )
                          ],
                        )
                      ]),
                    ],
                  ),
                  12.h,
                  Wrap(
                    key: Key(pickedFiles.value.length.toString()),
                    children: [
                      ...linkImages.value
                          .map((e) => SmallImageCard(
                                width: width / 2,
                                isLoadingImages: isLoadingImages.value,
                                image: NetworkImage(e),
                                remove: () {
                                  linkImages.update((val) {
                                    val?.remove(e);
                                  });
                                },
                              ))
                          .toList(),
                      ...pickedFiles.value
                          .map((e) => SmallImageCard(
                                width: width / 2,
                                isLoadingImages: isLoadingImages.value,
                                image: MemoryImage(e),
                                remove: () {
                                  pickedFiles.update((val) {
                                    val?.remove(e);
                                  });
                                },
                              ))
                          ,
                      /*    Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: () {
                              ImagePicker()
                                  .pickMultiImage()
                                  .then((value) async {
                                for (var element in value) {
                                  final data = await element.readAsBytes();
                                  pickedFiles.update((val) {
                                    val?.add(data);
                                  });
                                }
                                waitAfter(666, () {
                                  scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: 333.milliseconds,
                                      curve: Curves.ease);
                                });
                              });
                              // ImagePicker().pickMultiImage().then((value) {
                              //   pickedFiles.update((val) {
                              //     val?.addAll(value.map((e) => File(e.path)));
                              //   });
                              // waitAfter(666, () {
                              //   scrollController.animateTo(
                              //       scrollController.position.maxScrollExtent,
                              //       duration: 333.milliseconds,
                              //       curve: Curves.ease);
                              // });
                              // });
                            },
                            child: DottedBorder(
                              radius: const Radius.circular(12),
                              strokeWidth: .30,
                              borderType: BorderType.RRect,
                              child: Container(
                                height: (width - 18) / 2.5,
                                width: width / 2 - 22,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.add),
                                    6.h,
                                    const EText("Ajouter des photos",
                                        weight: FontWeight.bold)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      */
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  bool isImage(Uint8List bytes) {
    if (bytes.length < 8) {
      return false;
    }

    // Check for JPEG (starts with 0xFFD8)
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return true;
    }

    // Check for PNG (starts with 0x89504E47)
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return true;
    }

    // Check for GIF (starts with "GIF87a" or "GIF89a")
    if (bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        (bytes[3] == 0x38 &&
            (bytes[4] == 0x37 || bytes[4] == 0x39) &&
            bytes[5] == 0x61)) {
      return true;
    }

    // Check for BMP (starts with "BM")
    if (bytes[0] == 0x42 && bytes[1] == 0x4D) {
      return true;
    }

    // Check for WebP (starts with "RIFF" and contains "WEBP")
    if (bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return true;
    }

    // Add more formats as needed

    return false;
  }
}
