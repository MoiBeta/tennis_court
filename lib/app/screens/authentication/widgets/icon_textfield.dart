import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextField extends StatefulWidget {
  const IconTextField({
    required this.iconName,
    this.isPassword,
    this.validator,
    this.hintText,
    this.controller,
    this.label,
    this.numbersOnly,
    super.key,
  });

  final String iconName;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextEditingController? controller;
  final String? label;
  final bool? numbersOnly;

  @override
  State<IconTextField> createState() => _IconTextFieldState();
}

class _IconTextFieldState extends State<IconTextField> {
  bool isObscured = false;

  @override
  void initState() {
    if (widget.isPassword ?? false) {
      isObscured = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: isObscured,
            keyboardType: (widget.numbersOnly ?? false)
                ? TextInputType.phone : null,
            inputFormatters: [
              if(widget.numbersOnly ?? false)
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: SvgPicture.asset(
                          'assets/svg/${widget.iconName}.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    color: Colors.grey,
                    width: 2,
                    height: 20,
                  ),
                ],
              ),
              suffixIcon: (widget.isPassword ?? false)
                  ? isObscured
                      ? GestureDetector(
                  child: const Icon(Icons.visibility_off_outlined),
                onTap: (){
                    setState(() {
                      isObscured = false;
                    });
                },
              )
                      : GestureDetector(
                onTap: (){
                  setState(() {
                    isObscured = true;
                  });
                },
                  child: const Icon(Icons.visibility_outlined),
              )
                  : null,
            ),
          ),
        ),
        if(widget.label != null)
        Positioned(
          top: 0,
          left: 0,
          child: Text(
            widget.label!,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
