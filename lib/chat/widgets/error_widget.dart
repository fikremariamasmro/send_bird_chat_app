import 'package:flutter/material.dart';
import 'package:send_bird_chat_app/core/index.dart';

class ErrorWidgetCard extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const ErrorWidgetCard({Key? key, required this.error, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error_outline, size: 68),
          const SizedBox(height: 20),
          Text(
            error,
            style: const TextStyle(fontSize: 16, color: PresetColors.danger),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(color: PresetColors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
