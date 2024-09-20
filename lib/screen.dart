import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_processing/images_modes/ascii.dart';
import 'package:image_processing/images_modes/dots.dart';
import 'package:image_processing/images_modes/matrix.dart';
import 'package:image_processing/images_modes/normal.dart';
import 'package:image_processing/images_modes/spiral.dart';

class ScreenWidget extends StatefulWidget {
  const ScreenWidget({super.key});

  @override
  State<ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  ImageMode mode = ImageMode.normal;
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: image == null
                  ? const Center(
                      child: Text('Selecione uma imagem'),
                    )
                  : switch (mode) {
                      ImageMode.normal => NormalImage(image!),
                      ImageMode.asc => Ascii(image!),
                      ImageMode.matrix => MatrixImage(image!),
                      ImageMode.dots => Dots(image!),
                      ImageMode.spiral => Spiral(image!),
                    },
            ),
          ),
          Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Seletor',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => const _ImageBottomSheet(),
                        );
                        if (result is XFile && context.mounted) {
                          image = await result.readAsBytes();
                          setState(() {});
                        }
                      },
                      child: const Text('Imagem'),
                    ),
                    if (image != null) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.memory(image!),
                      ),
                    ],
                    const SizedBox(
                      height: 30,
                    ),
                    ToggleButtons(
                      borderRadius: BorderRadius.circular(15),
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      borderColor: Theme.of(context).colorScheme.onPrimary,
                      color: Theme.of(context).colorScheme.onPrimary,
                      selectedColor:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                      direction: Axis.vertical,
                      onPressed: (int index) {
                        setState(() {
                          mode = ImageMode.values[index];
                        });
                      },
                      isSelected:
                          ImageMode.values.map((e) => e == mode).toList(),
                      children: ImageMode.values
                          .map(
                            (e) => Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.label),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ImageMode {
  normal('Normal'),
  asc('ASCII'),
  matrix('Matrix'),
  dots('Pontos'),
  spiral('Espiral');

  final String label;

  const ImageMode(this.label);
}

class _ImageBottomSheet extends StatelessWidget {
  const _ImageBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!kIsWeb &&
                !(Theme.of(context).platform == TargetPlatform.windows))
              ListTile(
                onTap: () async {
                  final picker = ImagePicker();
                  final result = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (result is XFile && context.mounted) {
                    Navigator.pop(context, result);
                  }
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
            ListTile(
              onTap: () async {
                final picker = ImagePicker();
                final result = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (result is XFile && context.mounted) {
                  Navigator.pop(context, result);
                }
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              leading: const Icon(Icons.file_present_sharp),
              title: const Text('Arquivo'),
            ),
          ],
        ),
      ),
    );
  }
}
