import 'package:betna/setup/enumerators.dart';
import 'package:betna/setup/main_provider.dart';
import 'package:betna/style/custom_text.dart';
import 'package:betna/style/responsive/screen_type_layout.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomBar();
}

class _CustomBar extends State<CustomBar> {
  @override
  Widget build(BuildContext context) {
    return const ScreenTypeLayout(
      desktop: Desktop(),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({Key? key}) : super(key: key);
  static const List<Map> genderOptions = [{'title':'English','value':Lang.EN},{'title':'Arabic','value':Lang.AR},{'title':'Turkish','value':Lang.TR}];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Style.lavenderBlack,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 48),
            height: 70,
            width: 200,
            child: Image.asset(
              'assets/logo/logo_no_background_en.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 150,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor:MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Style.lavender.withOpacity(0.4);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) return Colors.transparent;
                  return Colors.transparent; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () {  },
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: CustomText(
                text: 'Contact us',
                color: Colors.white,
                size: 24,
                height: 2,
              ),
            ),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: CustomText(
              text: 'projects',
              color: Colors.white,
              size: 24,
              height: 2,
            ),
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: CustomText(
              text: 'Resale',
              color: Colors.white,
              size: 24,
              height: 2,
            ),
          ),
          const SizedBox(
            width: 150,
          ),
          //git config --global gpg.program C:\Program Files (x86)\Gpg4win\bin
          SizedBox(
            width: 150,
            child: FormBuilderDropdown<Map>(
              name: 'lang',
              initialValue: const {'title':'English','value':Lang.EN},
              dropdownColor: Style.orchid,
              iconSize: 36,
              decoration: const InputDecoration(
                hoverColor: Colors.white,
                iconColor: Colors.white,
                hintText: 'Select Gender',
              ),
              items: genderOptions
                  .map((gender) => DropdownMenuItem(
                alignment: AlignmentDirectional.center,
                value: gender,
                onTap: () async {
                  await Provider.of<MainProvider>(context,listen: false).changeCurrentLang(gender['value']);
                },
                child: Container(
                  width: 100,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: CustomText(
                    text: gender['title'],
                    color: Colors.white,
                    size: 24,
                    height: 2,
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
