import 'package:avatar_maker/avatar_maker.dart';
import 'package:get/get.dart';

/// Génère le SVG d'un avatar à partir d'une chaîne JSON d'options
Future<String> generateAvatarSvgFromJson(String jsonAvatarOptions) async {
  // Sauvegarder temporairement les options actuelles de l’utilisateur courant
  String currentUserOptions = await AvatarMakerController.getJsonOptions();

  // Définir les options de l’autre utilisateur
  AvatarMakerController.setJsonOptions(jsonAvatarOptions);

  // Générer le SVG
  String svgString = Get.find<AvatarMakerController>().drawAvatarSVG();

  // Restaurer les options de l’utilisateur courant
  AvatarMakerController.setJsonOptions(currentUserOptions);

  return svgString;
}
