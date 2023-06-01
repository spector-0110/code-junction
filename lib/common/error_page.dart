import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.content});
  final content;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(content),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(content: error),
    );
  }
}
