import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Color? fillColor;
  final double? boderRadius;
  final TextEditingController controller;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final bool black;
  const CustomTextField(
      {required this.controller,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.padding,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.enabled = true,
      this.black = false,
      Key? key,
      this.boderRadius,
      this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                labelText!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: black ? null : Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            readOnly: readOnly,
            validator: validator,
            onTap: onTap,
            onChanged: onChanged,
            enabled: enabled,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: prefixIcon,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context, boderRadius),
                focusedBorder: border(context, boderRadius,
                    color: readOnly ? null : Theme.of(context).primaryColor),
                errorBorder: border(context, boderRadius,
                    color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context, boderRadius),
                filled: true,
                fillColor: fillColor ?? Colors.transparent,
                contentPadding: const EdgeInsets.all(18),
                suffixIcon: suffixIcon),
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, double? boderRadius,
          {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).cardColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(boderRadius ?? 50),
      );
}

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  const CustomDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          DropdownButtonFormField(
            iconDisabledColor: Theme.of(context).primaryColor,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: hintText,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context),
                focusedBorder:
                    border(context, color: Theme.of(context).primaryColor),
                errorBorder:
                    border(context, color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context),
                filled: true,
                fillColor: Theme.of(context).disabledColor,
                contentPadding: const EdgeInsets.all(15),
                suffixIcon: suffixIcon),
            style: Theme.of(context).textTheme.bodyLarge,
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).cardColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      );
}
