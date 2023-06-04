import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDialog {
  static Future<void> showDialogEx(BuildContext context,
      {String? title, String? content}) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title ?? ''),
        content: Text(content ?? ''),
        actions: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 218, 168, 121),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
                      selectionColor: Color.fromARGB(255, 218, 168, 121),
                    )),
              ))
            ],
          )
        ],
      ),
    );
  }
}
