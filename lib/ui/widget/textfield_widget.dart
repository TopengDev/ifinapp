import 'package:ifinapp/common/common.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool obscure;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final bool readOnly;
  final Widget? suffix;
  final Function()? onTap;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.hint,
    this.obscure = false,
    this.onChanged,
    this.validator,
    this.inputType,
    this.readOnly = false,
    this.suffix,
    this.onTap,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _isObscure = false;

  @override
  void initState() {
    if (widget.obscure) _isObscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      keyboardType: widget.inputType,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: (widget.suffix != null)
            ? widget.suffix
            : widget.obscure
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    child: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : const SizedBox(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
    );
  }
}
