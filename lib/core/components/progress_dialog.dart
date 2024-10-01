import 'package:flutter/material.dart';

class CircularPrgressAlertDialog extends StatelessWidget {
  const CircularPrgressAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: Center(child: CircularProgressIndicator()),
    );
  }
}
