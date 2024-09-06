import 'package:code/Utils/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: SearchBar(
        textCapitalization: TextCapitalization.words,
        constraints: BoxConstraints(
          minHeight: 50.h,
        ),
        backgroundColor:
            const MaterialStatePropertyAll(Palette.backgroundColor),
        surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r))),
        hintText: "Search for anything...",
        hintStyle: const MaterialStatePropertyAll(TextStyle(
          color: Palette.disabledColor,
        )),
        trailing: const [
          FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: Palette.secoundaryText,
          ),
        ],
      ),
    );
  }
}
