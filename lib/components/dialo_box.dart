import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controler;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controler,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controler,
              autofocus: true,
              maxLines: null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a  new task'),
            ),

            //buttons -> save + cancel

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //censel button
                MyButton(text: 'Cancel', onPressed: onCancel),
                //save button

                const SizedBox(width: 8),

                MyButton(text: 'Save', onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
