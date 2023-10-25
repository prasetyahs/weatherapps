import 'package:weather_apps/utilities/exports.dart';

class WeatherTextField extends GetWidget {
  const WeatherTextField(this.hint,
      {super.key,
      required this.textEditingController,
      this.suffixIcon,
      this.obsecureText = false,
      this.textInputType = TextInputType.text});
  final String hint;
  final TextEditingController textEditingController;
  final dynamic suffixIcon;
  final bool obsecureText;
  final TextInputType textInputType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
        controller: textEditingController,
        obscureText: obsecureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelText: hint,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
