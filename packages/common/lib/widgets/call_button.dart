import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        openDialer(context, phoneNumber);
      },
      icon: Icon(Icons.call, color: appColors.ms.whiteSwNero(context)),
      style: IconButton.styleFrom(
          backgroundColor: Colors.lightBlue.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      tooltip: 'Contact on Call',
    );
  }

  Future<void> openDialer(BuildContext context, String phoneNumber) async {
    final cleanedNumber = phoneNumber.trim();
    final uri = Uri(scheme: 'tel', path: cleanedNumber);

    //debugPrint('--- 📞 Dialer Helper Debug ---');
    //debugPrint('Dial URI: $uri');

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      //debugPrint('❌ Could not launch dialer: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open dialer')),
        );
      }
    }
  }
}
