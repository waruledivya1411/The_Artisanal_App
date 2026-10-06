import 'package:artisanal_lens/domain/entities/shot_type.dart';
import 'package:artisanal_lens/features/capture/capture_session_controller.dart';
import 'package:artisanal_lens/features/capture/presentation/capture_reference_page.dart';
import 'package:artisanal_lens/features/checklist/click_social_frames.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/live_camera_harness.dart';

void main() {
  testWidgets('Capture shows the camera-layout reference before the shutter',
      (tester) async {
    final template = asTemplate(clickSocialFrames[0]);
    await tester.pumpWidget(
      cameraHarness(
        session: CaptureSession(
          setId: 'set_1',
          shotType: ShotType.sareePhotography,
          slotIndex: 0,
          skipsStyle: true,
          template: template,
        ),
        categoryId: 'saree',
        child: const CaptureReferencePage(setId: 'set_1'),
      ),
    );

    expect(find.text('PLACE IT LIKE THIS'), findsOneWidget);
    expect(find.text('FULL DISPLAY'), findsOneWidget);
    expect(find.text('OPEN CAMERA'), findsOneWidget);
    expect(find.text('Whole piece inside the dashed box'), findsOneWidget);
  });
}
