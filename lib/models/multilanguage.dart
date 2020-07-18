import 'labelTexts.dart';

class MultiLanguage {

  // 1 = Portuguese
  // 2 = English (Default)
  // 3 = Spanish
  int _typeOfLanguage = 2;

  List<LabelTexts> _listLabelTexts = [
    LabelTexts(typeOfPage: "Main", typeOfProperty: "Title",
        labelTextPortuguese: "Análise de Portfolios - Demo",
        labelTextEnglish: "Portfolio Analytics - Demo",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "AppBar",
        labelTextPortuguese: "Entrar",
        labelTextEnglish: "Login",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "FlatButton",
        labelTextPortuguese: "Criar Conta",
        labelTextEnglish: "Create Account",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "Email",
        labelTextPortuguese: "Email inválido.",
        labelTextEnglish: "Invalid Email.",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "Password",
        labelTextPortuguese: "Senha inválida.",
        labelTextEnglish: "Invalid Password.",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "PasswordHint",
        labelTextPortuguese: "Senha",
        labelTextEnglish: "Password",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "MaterialButton",
        labelTextPortuguese: "Entrar",
        labelTextEnglish: "Login",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "Login", typeOfProperty: "AlignForgot",
        labelTextPortuguese: "Esqueceu a Senha",
        labelTextEnglish: "Forgot the Password",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "HomePage", typeOfProperty: "AppBar",
        labelTextPortuguese: "Noticias",
        labelTextEnglish: "News",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "HomePage", typeOfProperty: "DrawerHead",
        labelTextPortuguese: "Análise das\nReceitas & Despesas\n& Portfolios",
        labelTextEnglish: "Portfolios\nGross & Expenses\nAnalysis",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "HomePage", typeOfProperty: "CenterError",
        labelTextPortuguese: "Ops!! Erro no site HG Brasil.",
        labelTextEnglish: "Ops!! Web site HG Brazil has error.",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "HomePage", typeOfProperty: "LabelBuy",
        labelTextPortuguese: "Compra",
        labelTextEnglish: "Buy",
        labelTextSpanish: ""),
    LabelTexts(typeOfPage: "HomePage", typeOfProperty: "LabelSell",
        labelTextPortuguese: "Venda",
        labelTextEnglish: "Sell",
        labelTextSpanish: "")
  ];

  void setTypeofLanguage(int typeOfLanguage) {
    if (typeOfLanguage <= 0 || typeOfLanguage > 3)
      this._typeOfLanguage = 2;
    else
      this._typeOfLanguage = typeOfLanguage;
  }

  int get getTypeofLanguage {
    return this._typeOfLanguage;
  }

  String getLabelText(String page, String property) {
    String _text;
    this._listLabelTexts.forEach((element) {
      if (element.typeOfPage.contains(page))
        if (element.typeOfProperty.contains(property))
          switch (this._typeOfLanguage) {
            case 1: _text = element.labelTextPortuguese; break;
            case 2: _text = element.labelTextEnglish; break;
            case 3: _text = element.labelTextSpanish; break;
            default: _text = ""; break;
          }
    });
    return _text;
  }

}