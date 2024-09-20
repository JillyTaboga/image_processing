import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6c5e00),
      surfaceTint: Color(0xff6c5e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbda717),
      onPrimaryContainer: Color(0xff211c00),
      secondary: Color(0xff6b5f00),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe748),
      onSecondaryContainer: Color(0xff544a00),
      tertiary: Color(0xff78592a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe9c087),
      onTertiaryContainer: Color(0xff4b3105),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff9ec),
      onSurface: Color(0xff1e1c12),
      onSurfaceVariant: Color(0xff4b4735),
      outline: Color(0xff7c7762),
      outlineVariant: Color(0xffcdc6ae),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333026),
      inversePrimary: Color(0xffdec73b),
      primaryFixed: Color(0xfffce355),
      onPrimaryFixed: Color(0xff211c00),
      primaryFixedDim: Color(0xffdec73b),
      onPrimaryFixedVariant: Color(0xff514700),
      secondaryFixed: Color(0xfffee301),
      onSecondaryFixed: Color(0xff201c00),
      secondaryFixedDim: Color(0xffdfc700),
      onSecondaryFixedVariant: Color(0xff504700),
      tertiaryFixed: Color(0xffffddb1),
      onTertiaryFixed: Color(0xff291800),
      tertiaryFixedDim: Color(0xffe9c087),
      onTertiaryFixedVariant: Color(0xff5d4215),
      surfaceDim: Color(0xffe0dacb),
      surfaceBright: Color(0xfffff9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf3e4),
      surfaceContainer: Color(0xfff4edde),
      surfaceContainerHigh: Color(0xffeee8d8),
      surfaceContainerHighest: Color(0xffe8e2d3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4d4300),
      surfaceTint: Color(0xff6c5e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff857500),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff4c4300),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff847500),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff593e11),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff906f3e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff9ec),
      onSurface: Color(0xff1e1c12),
      onSurfaceVariant: Color(0xff474331),
      outline: Color(0xff645f4c),
      outlineVariant: Color(0xff807b66),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333026),
      inversePrimary: Color(0xffdec73b),
      primaryFixed: Color(0xff857500),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff695c00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff847500),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff685c00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff906f3e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff755628),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe0dacb),
      surfaceBright: Color(0xfffff9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf3e4),
      surfaceContainer: Color(0xfff4edde),
      surfaceContainerHigh: Color(0xffeee8d8),
      surfaceContainerHighest: Color(0xffe8e2d3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff282200),
      surfaceTint: Color(0xff6c5e00),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4d4300),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff282200),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4c4300),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff311e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff593e11),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff9ec),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff272414),
      outline: Color(0xff474331),
      outlineVariant: Color(0xff474331),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff333026),
      inversePrimary: Color(0xffffed90),
      primaryFixed: Color(0xff4d4300),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff342d00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4c4300),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff332d00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff593e11),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3f2800),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe0dacb),
      surfaceBright: Color(0xfffff9ec),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffaf3e4),
      surfaceContainer: Color(0xfff4edde),
      surfaceContainerHigh: Color(0xffeee8d8),
      surfaceContainerHighest: Color(0xffe8e2d3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdec73b),
      surfaceTint: Color(0xffdec73b),
      onPrimary: Color(0xff383000),
      primaryContainer: Color(0xffa79300),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff383100),
      secondaryContainer: Color(0xffefd500),
      onSecondaryContainer: Color(0xff484000),
      tertiary: Color(0xffffddb1),
      onTertiary: Color(0xff442b01),
      tertiaryContainer: Color(0xffdab27b),
      onTertiaryContainer: Color(0xff3e2700),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff15130b),
      onSurface: Color(0xffe8e2d3),
      onSurfaceVariant: Color(0xffcdc6ae),
      outline: Color(0xff97917b),
      outlineVariant: Color(0xff4b4735),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d3),
      inversePrimary: Color(0xff6c5e00),
      primaryFixed: Color(0xfffce355),
      onPrimaryFixed: Color(0xff211c00),
      primaryFixedDim: Color(0xffdec73b),
      onPrimaryFixedVariant: Color(0xff514700),
      secondaryFixed: Color(0xfffee301),
      onSecondaryFixed: Color(0xff201c00),
      secondaryFixedDim: Color(0xffdfc700),
      onSecondaryFixedVariant: Color(0xff504700),
      tertiaryFixed: Color(0xffffddb1),
      onTertiaryFixed: Color(0xff291800),
      tertiaryFixedDim: Color(0xffe9c087),
      onTertiaryFixedVariant: Color(0xff5d4215),
      surfaceDim: Color(0xff15130b),
      surfaceBright: Color(0xff3c392f),
      surfaceContainerLowest: Color(0xff100e06),
      surfaceContainerLow: Color(0xff1e1c12),
      surfaceContainer: Color(0xff222016),
      surfaceContainerHigh: Color(0xff2c2a20),
      surfaceContainerHighest: Color(0xff37352a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe3cb3f),
      surfaceTint: Color(0xffdec73b),
      onPrimary: Color(0xff1b1600),
      primaryContainer: Color(0xffa79300),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff383100),
      secondaryContainer: Color(0xffefd500),
      onSecondaryContainer: Color(0xff252000),
      tertiary: Color(0xffffddb1),
      onTertiary: Color(0xff3c2600),
      tertiaryContainer: Color(0xffdab27b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff15130b),
      onSurface: Color(0xfffffaf4),
      onSurfaceVariant: Color(0xffd2cbb3),
      outline: Color(0xffa9a38c),
      outlineVariant: Color(0xff89836e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d3),
      inversePrimary: Color(0xff534800),
      primaryFixed: Color(0xfffce355),
      onPrimaryFixed: Color(0xff151100),
      primaryFixedDim: Color(0xffdec73b),
      onPrimaryFixedVariant: Color(0xff3f3600),
      secondaryFixed: Color(0xfffee301),
      onSecondaryFixed: Color(0xff151100),
      secondaryFixedDim: Color(0xffdfc700),
      onSecondaryFixedVariant: Color(0xff3e3600),
      tertiaryFixed: Color(0xffffddb1),
      onTertiaryFixed: Color(0xff1b0f00),
      tertiaryFixedDim: Color(0xffe9c087),
      onTertiaryFixedVariant: Color(0xff4a3105),
      surfaceDim: Color(0xff15130b),
      surfaceBright: Color(0xff3c392f),
      surfaceContainerLowest: Color(0xff100e06),
      surfaceContainerLow: Color(0xff1e1c12),
      surfaceContainer: Color(0xff222016),
      surfaceContainerHigh: Color(0xff2c2a20),
      surfaceContainerHighest: Color(0xff37352a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf4),
      surfaceTint: Color(0xffdec73b),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe3cb3f),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffffff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffefd500),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffffaf7),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffedc48b),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff15130b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf4),
      outline: Color(0xffd2cbb3),
      outlineVariant: Color(0xffd2cbb3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e2d3),
      inversePrimary: Color(0xff312a00),
      primaryFixed: Color(0xffffe864),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffe3cb3f),
      onPrimaryFixedVariant: Color(0xff1b1600),
      secondaryFixed: Color(0xffffe853),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe4cc00),
      onSecondaryFixedVariant: Color(0xff1a1600),
      tertiaryFixed: Color(0xffffe2be),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffedc48b),
      onTertiaryFixedVariant: Color(0xff221300),
      surfaceDim: Color(0xff15130b),
      surfaceBright: Color(0xff3c392f),
      surfaceContainerLowest: Color(0xff100e06),
      surfaceContainerLow: Color(0xff1e1c12),
      surfaceContainer: Color(0xff222016),
      surfaceContainerHigh: Color(0xff2c2a20),
      surfaceContainerHighest: Color(0xff37352a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
