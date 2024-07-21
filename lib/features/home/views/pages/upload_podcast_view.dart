import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lizn/core/theme/app_pallete.dart';
import 'package:lizn/core/utils/extensions.dart';
import 'package:lizn/core/utils/utils.dart';
import 'package:lizn/core/widgets/button.dart';
import 'package:lizn/core/widgets/text_input.dart';
import 'package:lizn/features/home/repositories/home_repositories.dart';
import 'package:lizn/features/home/viewmodel/home_viewmodel.dart';
import 'package:lizn/features/home/views/widgets/audio_wave.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UploadSongView extends ConsumerStatefulWidget {
  const UploadSongView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongViewState();
}

class _UploadSongViewState extends ConsumerState<UploadSongView> {
  final TextEditingController _artisteCOntroller = TextEditingController();
  final TextEditingController _songNameController = TextEditingController();
  final selectedColor = Pallete.cardColor.notifier;
  File? selectedImage;
  File? selectedAudio;
  Color imageBackgroundColor = Pallete.backgroundColor;

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
      _updateImageBackgroundColor(pickedImage);
    }
  }

  Future<void> _updateImageBackgroundColor(File imageFile) async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(FileImage(imageFile));
    setState(() {
      imageBackgroundColor =
          paletteGenerator.dominantColor?.color ?? Pallete.backgroundColor;
    });
  }

  @override
  void dispose() {
    _artisteCOntroller.dispose();
    _songNameController.dispose();
    selectedColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(homeViewModelProvider.select((val) => val?.isLoading == true));
    return Scaffold(
      // backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: 'Upload Podcast'.txt20(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              imageBackgroundColor,
              Pallete.backgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: 16.padH,
          child: Column(
            children: [
              20.sbH,
              selectedImage != null
                  ? Container(
                      height: 200.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: DecorationImage(
                          image: FileImage(selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).tap(onTap: selectImage)
                  : DottedBorder(
                      color: Pallete.borderColor,
                      dashPattern: const [10, 4],
                      radius: const Radius.circular(16),
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      child: SizedBox(
                        height: 150.h,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                PhosphorIconsBold.folder,
                                size: 35.sp,
                              ),
                              15.sbH,
                              'Select the thumbnail for your podcast'.txt16(),
                            ],
                          ),
                        ),
                      ),
                    ).tap(onTap: selectImage),
              30.sbH,
              selectedAudio != null
                  ? Column(
                      children: [
                        AudioWave(path: selectedAudio!.path),
                        10.sbH,
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedAudio = null;
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(PhosphorIconsFill.trash),
                              5.sbW,
                              'Remove'.txt18()
                            ],
                          ),
                        )
                      ],
                    )
                  : BButton(
                      onTap: selectAudio,
                      text: 'Pick audio file',
                    ),
              20.sbH,
              TextInputWidget(
                inputTitle: 'Creator',
                hintText: '',
                controller: _artisteCOntroller,
              ),
              10.sbH,
              TextInputWidget(
                inputTitle: 'Podcast name',
                hintText: '',
                controller: _songNameController,
              ),
              10.sbH,
              ColorPicker(
                color: selectedColor.value,
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                onColorChanged: (Color color) {
                  selectedColor.value = color;
                },
              ),
              20.sbH,
              [
                _songNameController,
                _artisteCOntroller,
              ].multiSync(
                builder: (context, child) {
                  bool validated = _songNameController.text.isNotEmpty &&
                      _artisteCOntroller.text.isNotEmpty &&
                      selectedAudio != null &&
                      selectedImage != null;

                  return AnimatedButton(
                    isLoading: isLoading,
                    content: 'Upload'.txt16(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    color: switch (validated) {
                      true => null,
                      false => Pallete.gradient2.withOpacity(0.5)
                    },
                    onTap: () async {
                      if (validated) {
                        ref.read(homeViewModelProvider.notifier).uploadPodcast(
                              selectedImage: selectedImage!,
                              selectedAudio: selectedAudio!,
                              podcastName: _songNameController.text.trim(),
                              creatorName: _artisteCOntroller.text.trim(),
                              selectedColor: imageBackgroundColor,
                            );
                      }
                    },
                  );
                },
              ),
              40.sbH,
            ],
          ),
        ),
      ),
    );
  }
}
