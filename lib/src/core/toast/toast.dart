import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:casino_test/main.dart';
import 'package:flutter/material.dart';

class CustomToast {
  CustomToast() {
    timer = Timer(const Duration(seconds: 3), dispose);
  }

  late Timer timer;

  toast(String message) {
    showDialog(
      context: navKey.currentContext!,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (context) => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ElasticIn(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12),
                  ],
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).then((value) => timer.cancel());
  }

  void dispose() {
    Navigator.of(navKey.currentContext!).pop();

    timer.cancel();
  }
}
