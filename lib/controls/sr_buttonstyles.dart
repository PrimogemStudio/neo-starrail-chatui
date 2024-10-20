import 'package:flutter/material.dart';
import 'package:neo_starrail_chatui/controls/sr_colors.dart';

var srStyle = ButtonStyle(
    animationDuration: const Duration(milliseconds: 150),
    overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return uiBtnBgPressed;
      } else if (states.contains(WidgetState.hovered)) {
        return uiBtnBgHover;
      }
      return uiBtnBg;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    shape: WidgetStateProperty.all(
        BeveledRectangleBorder(borderRadius: BorderRadius.circular(0))),
    backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      return uiBtnBg;
    }),
    elevation: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return 0;
      } else if (states.contains(WidgetState.hovered)) {
        return 3;
      }
      return 2;
    }),
    splashFactory: NoSplash.splashFactory,
    textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16, fontFamily: "StarRailFont_bundle")));

var srStyleList = ButtonStyle(
    animationDuration: const Duration(milliseconds: 150),
    overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return uiBtnBgPressedSpec;
      } else if (states.contains(WidgetState.hovered)) {
        return uiBtnBg;
      }
      return uiSurfaceColor;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    shape: WidgetStateProperty.all(
        BeveledRectangleBorder(borderRadius: BorderRadius.circular(0))),
    backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      return uiSurfaceColor;
    }),
    elevation: WidgetStateProperty.all(0),
    splashFactory: NoSplash.splashFactory,
    textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16, fontFamily: "StarRailFont_bundle")),
    side: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return BorderSide(color: uiBtnBorder, width: 0.75);
      } else if (states.contains(WidgetState.hovered)) {
        return BorderSide(color: uiBtnBorder, width: 0.75);
      }
      return const BorderSide(color: Colors.transparent, width: 0.75);
    }));

var srStyleImage = ButtonStyle(
    padding: WidgetStateProperty.all(EdgeInsets.zero),
    animationDuration: const Duration(milliseconds: 100),
    overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return uiBtnBgPressedSpec;
      } else if (states.contains(WidgetState.hovered)) {
        return uiBtnBg;
      }
      return uiSurfaceColor;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.black),
    shape: WidgetStateProperty.all(
        BeveledRectangleBorder(borderRadius: BorderRadius.circular(0))),
    backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      return uiSurfaceColor;
    }),
    elevation: WidgetStateProperty.all(0),
    splashFactory: NoSplash.splashFactory,
    textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 16, fontFamily: "StarRailFont_bundle")),
    side: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return const BorderSide(
            color: Color.fromARGB(125, 255, 255, 255), width: 1);
      } else if (states.contains(WidgetState.hovered)) {
        return const BorderSide(color: Colors.white, width: 1);
      }
      return const BorderSide(
          color: Color.fromARGB(0, 255, 255, 255), width: 1);
    }));
