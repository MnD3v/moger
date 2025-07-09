import 'package:moger_web/scr/configs/app/export.dart';


class AppTheme {
  static ThemeData get theme => ThemeData(
        fontFamily: Fonts.poppins,
        primaryColor: AppColors.color500,
        textTheme: textTheme,
        appBarTheme: appBarTheme,
        dialogTheme: dialogTheme,

          
        scaffoldBackgroundColor: AppColors.background,  
        dividerColor: Colors.black12,
        primarySwatch: Colors.pink
        
      );

  static DialogTheme get dialogTheme {
    return DialogTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor:AppColors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)));
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: .4,
        toolbarHeight: 65,
        iconTheme: IconThemeData(
          color: AppColors.textColor,
        ));
  }

  static TextTheme get textTheme {
    return TextTheme(
        titleSmall: TextStyle(color: AppColors.blue),
        bodySmall: TextStyle(color: AppColors.textColor));
  }
}