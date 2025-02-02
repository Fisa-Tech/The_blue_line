import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Components/main_frame.dart';
import 'package:myapp/Theme/app_colors.dart';
import 'package:myapp/Theme/app_text_styles.dart';

class AvatarCustomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MainFrame(
      currentIndex: 0, 
      title: "Avatar", 
      appBarVariant: AppBarVariant.backAndSave,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: AvatarMakerAvatar(
                  backgroundColor: AppColors.lightDark,
                ),
              ),
            ),
            AvatarMakerCustomizer(
              theme: AvatarMakerThemeData(
                primaryBgColor: AppColors.grey,
                secondaryBgColor: AppColors.lightDark,
                selectedTileDecoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primary,
                    width: 4,
                  ),
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelTextStyle: AppTextStyles.headline2,
                unselectedIconColor: AppColors.textPrimary,
                selectedIconColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}