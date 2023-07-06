import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled12/utils/colors.dart';

class InputTextField extends StatelessWidget {
  String label;
  String hint;
  TextInputType? inputType;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  String? prefixText;
  TextInputAction actionType;

  InputTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.controller,
    this.inputType,
    this.inputFormatters,
    this.prefixText,
    this.actionType = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 5),
          TextField(
            focusNode: FocusNode(),
            inputFormatters: inputFormatters,
            controller: controller,
            textInputAction: actionType,
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: (prefixText != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Text(prefixText!),
                    )
                  : null,
              hintText: hint,
              filled: true,
              fillColor: ColorsApp.c_FAFAFA,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: ColorsApp.c_D9D9D9),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: ColorsApp.c_454545),
              ),
            ),
          )
        ],
      ),
    );
  }
}
