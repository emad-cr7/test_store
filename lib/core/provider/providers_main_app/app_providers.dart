import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../features/cart/cart_controller.dart';
import '../../../features/favorite/favorite_controller.dart';
import '../../language/language_controller.dart';
import '../provider_controller.dart';

List<SingleChildWidget> get appProviders => [
  ChangeNotifierProvider(create: (_) => ProviderController()),
  ChangeNotifierProvider(create: (_) => FavoriteController()),
  ChangeNotifierProvider(create: (_) => CartController()),
  ChangeNotifierProvider(create: (_) => LanguageController()..init()),
];