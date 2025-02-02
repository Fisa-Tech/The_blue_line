import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Theme/app_colors.dart';

import '../Utils/avatar_svg_generator.dart';  // Assurez-vous d'avoir ce fichier pour les couleurs

class OtherUserAvatarWidget extends StatefulWidget {
  final String jsonAvatarOptions;
  final double radius;

  const OtherUserAvatarWidget({
    Key? key,
    required this.jsonAvatarOptions,
    this.radius = 50.0,  // Taille par défaut
  }) : super(key: key);

  @override
  _OtherUserAvatarWidgetState createState() => _OtherUserAvatarWidgetState();
}

class _OtherUserAvatarWidgetState extends State<OtherUserAvatarWidget> {
  String svgString = '';

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    String newSvgString = await generateAvatarSvgFromJson(widget.jsonAvatarOptions);
    setState(() {
      svgString = newSvgString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightDark,  // Fond du cercle
      ),
      child: ClipOval(
        child: Center(
          child: svgString.isNotEmpty
              ? SvgPicture.string(
                  svgString,
                  fit: BoxFit.cover,
                )
              : const CircularProgressIndicator(),  // Indicateur de chargement
        ),
      ),
    );
  }
}
