import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.obscureText = false,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.contentPadding,
    this.controller,
    this.focusNode,
    this.iconw,
    this.suffix,
    this.prefix,
    this.isPassword = false,
    this.autofocus = false,
    this.onFieldSubmitted,
  });
  String hint;
  Function(String)? onChanged;
  bool obscureText, isPassword = false;
  bool autofocus;
  IconData? icon;
  Widget? iconw, suffix, prefix;
  TextInputType keyboardType;
  EdgeInsetsGeometry? contentPadding;
  TextEditingController? controller;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      onFieldSubmitted: widget.onFieldSubmitted,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      controller: widget.controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This Field is Required.';
        } else if (value!.length < 8) {
          return 'This Field Must be greater than 8 characters.';
        } else if (value.length > 50) {
          return 'length must be less than 50  Characters.';
        } else {
          return null;
        }
      },
      obscureText: widget.isPassword ? isObscure : false,
      onChanged: widget.onChanged,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        suffixIcon: !widget.isPassword
            ? Icon(
                widget.icon,
                color: Colors.white,
              )
            : IconButton(
                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ), // Set the icon color to white
        hintStyle: const TextStyle(color: Colors.white),
        suffix: widget.prefix, // Add this line to set the icon color
        contentPadding: widget.contentPadding,
        filled: true,
        fillColor: Colors.transparent,
        focusedErrorBorder: buildBorder(),
        disabledBorder: buildBorder(),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        errorBorder: buildBorder(),
        hintText: widget.hint,
      ),
      keyboardType: widget.keyboardType,
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
