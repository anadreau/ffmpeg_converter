import 'package:creator/creator.dart';
import 'package:ffmpeg_converter/ffmpeg_install_helper/ffmpeg_verify_install.dart';
import 'package:ffmpeg_converter/screens/converter_screen.dart';
import 'package:ffmpeg_converter/utils/common_variables.dart';

import 'package:flutter/material.dart';

//TODO: #9 Implement function to check if FFMPEG is downloaded and download and install if needed. @anadreau

void main() {
  runApp(CreatorGraph(child: const ConverterApp()));
}

class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'bugFix',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        body: Watcher((context, ref, child) {
          ref.read(verifyFfmpegInstallCreator);
          var ffmpegInstalled = ref.watch(ffmpegInstallStatusCreator);
          if (ffmpegInstalled == FfmpegInstallStatus.installed) {
            return const ConverterScreen();
          } else {
            //Implement install of ffmpeg here
            return const Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ffmpeg is not installed on this device.'),
                SizedBox(width: 15),
                CircularProgressIndicator()
              ],
            ));
          }
        }),
      ),
    );
  }
}
