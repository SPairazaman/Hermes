import 'package:flutter/material.dart';

class GenericModal {

  static Future<bool?> show({
    required BuildContext context,
    required Widget child
  }) async {

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(modalContext).viewInsets.bottom,
          ),
          child: child,
        );

      },
    );
    return result;
  }
}