import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({
    super.key,
    required this.phoneNumber,
    this.message,
  });

  final String phoneNumber;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openWhatsapp(
          context: context, phoneNumber: phoneNumber, message: message),
      icon: Icon(Icons.message, color: appColors.ms.whiteSwNero(context)),
      style: IconButton.styleFrom(
          backgroundColor: Colors.green.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      tooltip: 'Contact on WhatsApp',
    );
  }

  static Future<void> openWhatsapp({
    required BuildContext context,
    required String phoneNumber,
    String? message,
  }) async {
    final cleanedNumber = phoneNumber.replaceAll("+", "").trim();

    // build query only if message exists
    final query = (message != null && message.trim().isNotEmpty)
        ? "&text=${Uri.encodeComponent(message)}"
        : "";

    final deepLink = Uri.parse('whatsapp://send?phone=$cleanedNumber$query');
    final fallback = Uri.parse(
        'https://wa.me/$cleanedNumber${query.replaceFirst('&', '?')}');

    try {
      await launchUrl(
        deepLink,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      try {
        await launchUrl(
          fallback,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        if (context.mounted) {
          showMessageSnackbar(
            context: context,
            message: 'Could not open WhatsApp',
          );
        }
      }
    }
  }
}

class WhatsAppHelper {
  /// Builds the order reminder message using OrderRules.
  static String buildOrderReminderMessage(OrderRules? rules) {
    if (rules == null || rules.isEmpty) {
      return """
🔔 Reminder:
Please confirm today\'s order at the earliest.

For any queries, contact your supply manager.

Thank you.
""";
    }

    final now = DateTime.now();
    final endToday = rules.orderEnd != null
        ? DateTime(now.year, now.month, now.day, rules.orderEnd!.hour,
            rules.orderEnd!.minute)
        : null;

    String remainingTimeText;

    if (endToday != null) {
      if (now.isBefore(endToday)) {
        final diff = endToday.difference(now);
        remainingTimeText = DFU.formatDuration(diff);
      } else {
        remainingTimeText = "Order window closed";
      }
    } else {
      remainingTimeText = "N/A";
    }

    return """
-----------------------------
📌 Order Reminder
-----------------------------
⏰ Remaining time to place order: $remainingTimeText

Please confirm your order within this time slot.

Regards,
${AppEnv.companyName} Management.
-----------------------------
""";
  }
}
