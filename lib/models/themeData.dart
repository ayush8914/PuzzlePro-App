
class ThemeDataModel {
  int isLightTheme;

  int colorSelected;

  ThemeDataModel()
      : isLightTheme = 0,
        colorSelected = 0;

  ThemeDataModel.create(this.isLightTheme, this.colorSelected);
}
