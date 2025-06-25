import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uimodex/models/utils/dimens.dart';
import 'package:uimodex/services/extension_services.dart';

class Utils {
  static GestureRecognizer recognizer(VoidCallback onTap) {
    return TapGestureRecognizer()..onTap = onTap;
  }

  static String timeFromNow(DateTime? date, [String extraText = '']) {
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) {
      switch (diff.inDays) {
        case > 364:
          return '${(diff.inDays / 365).round()} years $extraText';
        case > 30:
          return '${(diff.inDays / 30.416).round()} days $extraText';
        case > 6:
          return '${(diff.inDays / 7).round()} weeks $extraText';
        case 1:
          return '1 day $extraText';
        default:
          return '${diff.inDays} days $extraText';
      }
    } else if (diff.inHours > 0) {
      if (diff.inHours == 1) return '1 hour $extraText';
      return '${diff.inHours} hours $extraText';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} min $extraText';
    }

    return 'Just now';
  }

  static TextStyle defTitleStyle([BuildContext? context]) {
    return TextStyle(
      fontSize: Dimens.fontExtraLarge,
      fontWeight: FontWeight.w600,
      color: context?.scheme.textColor,
    );
  }

  static EdgeInsets paddingHoriz(double padding) {
    return EdgeInsets.symmetric(horizontal: padding);
  }

  static ShapeBorder roundedRectangle(double border) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(border));
  }
}
