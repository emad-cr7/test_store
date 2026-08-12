import 'package:flutter/widgets.dart';

import '../../../core/l10n/app_localizations.dart';

/// يترجم اسم الفئة (Category) بناءً على الـ id الثابت في categories_data.dart
/// لو الـ id مش معروف، بيرجع الاسم الأصلي القادم من الـ API كما هو.
String localizedCategoryName(BuildContext context, String? id, String? fallbackName) {
  final t = AppLocalizations.of(context)!;

  switch (id) {
    case '1':
      return t.categoryClothes;
    case '2':
      return t.categoryElectronics;
    case '3':
      return t.categoryFurniture;
    case '4':
      return t.categoryShoes;
    case '5':
      return t.categoryOthers;
    default:
      return fallbackName ?? t.category;
  }
}
