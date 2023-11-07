import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/my_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          children: [
            //get user input
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add a  new task'),
            ),

            //buttons -> save + cancel

            Row(
              children: [
                //save button
                MyButton(text: 'Save', onPressed: () {}),

                //censel button
                MyButton(text: 'Cancel', onPressed: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
