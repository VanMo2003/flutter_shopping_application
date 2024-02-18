import 'package:flutter/material.dart';

Future<void> showDialogDelete(
    BuildContext context, String task, Function() onPressed) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        title: const Text('Delete?'),
        content: Text("Bạn muốn xóa công việc: $task ?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('không'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('có'),
            onPressed: () {
              Navigator.of(context).pop();
              onPressed();
            },
          ),
        ],
      );
    },
  );
}
