import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:ffmpeg_converter/ffmpeg_install_helper/ffmpeg_install_helper.dart';
import 'package:ffmpeg_converter/global_variables/common_variables.dart';
import 'package:ffmpeg_converter/utils/pwsh_cmd.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TO-DO: #18 add ffmpeg installation ability for linux and macos. @anadreau
//TO-DO: #19 implement ffmpeg command depending on OS. @anadreau

//Creator that returns non
final ffmpegInstallStatusTrackerProvider = Provider<double>((ref) {
  final status = ref.watch(ffmpegInstallStatusProvider);

  final installStatus = switch (status) {
    InstallStatus.notInstalled => 0.0,
    InstallStatus.createDir => 2 / 9,
    InstallStatus.downloadPackage => 3 / 9,
    InstallStatus.extractPackage => 4 / 9,
    InstallStatus.movePackage => 5 / 9,
    InstallStatus.cleanUpDir => 6 / 9,
    InstallStatus.setPathVariable => 7 / 9,
    InstallStatus.updatePathVariable => 8 / 9,
    InstallStatus.installed => 1.0,
    InstallStatus.error => 0.0
  };
  return installStatus;
});

final verifyFfmpegInstallProvider = Provider((ref) async {
  final result = await Isolate.run(() => Process.runSync('powershell.exe',
      ['-Command', updateEvironmentVariableCmd, ';', verifyInstallCmd],
      runInShell: true,),);

  if (result.exitCode == 0) {
    log('${result.stdout}');
    log('${result.stderr}');
    if (result.stdout != null) {
      log('${result.stdout}');
      final installed = ref
          .read(ffmpegInstallStatusProvider.notifier)
          .update((state) => InstallStatus.installed);
      log('Ffmpeg is $installed');
    } else {
      ref
          .read(ffmpegInstallStatusProvider.notifier)
          .update((state) => InstallStatus.notInstalled);
    }
  } else {
    log('stdout: ${result.stdout}');
    log('error: ${result.stderr}');
  }
});
