import 'package:ffmpeg_converter/ffmpeg_install_helper/ffmpeg_install_helper.dart';
import 'package:ffmpeg_converter/ffmpeg_install_helper/ffmpeg_verify_install.dart';
import 'package:ffmpeg_converter/global_variables/common_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstallerScreen extends StatelessWidget {
  const InstallerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: ColumnConsumer());
  }
}

class ColumnConsumer extends ConsumerWidget {
  const ColumnConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var installStatus = ref.watch(ffmpegInstallStatusProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        switch (installStatus) {
          InstallStatus.notInstalled => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Ffmpeg is not installed on this device.'),
              )),
          InstallStatus.installed => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ref.watch(ffmpegInstallStatusProvider).message),
              )),
          _ => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(ref.watch(ffmpegInstallStatusProvider).message),
              )),
        },
        const SizedBox(
          height: 15,
        ),
        switch (installStatus) {
          InstallStatus.notInstalled => const SizedBox(),
          InstallStatus.installed => const SizedBox(),
          _ => const Padding(
              padding: EdgeInsets.fromLTRB(100, 0, 100, 15),
              //TO-DO: #16 Smooth out animation of indicator. @anadreau
              child: LinearProgressIndicatorConsumer(),
            ),
        },
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: StatusProviderButton(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LinearProgressIndicatorConsumer extends ConsumerWidget {
  const LinearProgressIndicatorConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LinearProgressIndicator(
      value: ref.watch(ffmpegInstallStatusTrackerProvider),
    );
  }
}

class StatusProviderButton extends ConsumerWidget {
  const StatusProviderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      onPressed: () {
        ref.read(ffmpegInstallProvider);
      },
      child: const Row(
        children: [
          Text('Install'),
          SizedBox(width: 8),
          Icon(Icons.install_desktop),
        ],
      ),
    );
  }
}
