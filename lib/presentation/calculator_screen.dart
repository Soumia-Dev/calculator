import 'package:calculator/utils/app_colors.dart';
import 'package:calculator/utils/buttons.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'functions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  Color primaryColor = AppColors.blue[0];
  Color secondaryColor = AppColors.blue[1];
  Color backgroundColor = AppColors.blue[2];
  String myAnswer = "0";
  static TextEditingController myInput = TextEditingController(text: "");
  FocusNode focusNode = FocusNode();
  late int position;
  late String expressionCleaned;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenSizeHeight =
        screenSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black26
          : backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              // height = 0.5 / 10
              Container(
                height: (screenSizeHeight) * 0.5 / 10,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            themeModeNotifier.value = ThemeMode.dark;
                          },
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Dark',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 5),
                        MaterialButton(
                          onPressed: () {
                            themeModeNotifier.value = ThemeMode.light;
                          },
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Light',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton<List>(
                      icon: const Icon(Icons.color_lens),
                      onSelected: (List color) {
                        setState(() {
                          primaryColor = color[0];
                          secondaryColor = color[1];
                          backgroundColor = color[2];
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return AppColors.namedColors.entries.map((entry) {
                          final colorName = entry.key;
                          final colorList = entry.value;
                          return PopupMenuItem<List>(
                            value: colorList,
                            child: Text(
                              colorName,
                              style: TextStyle(color: colorList[0]),
                            ),
                          );
                        }).toList();
                      },
                    )
                  ],
                ),
              ),
              // height = 2.5 / 10
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                margin: const EdgeInsets.only(top: 20),
                height: (screenSizeHeight) * 2.5 / 10,
                child: Column(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? primaryColor
                                  : secondaryColor,
                          selectionHandleColor: primaryColor,
                        ),
                      ),
                      child: Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: myInput,
                          focusNode: focusNode,
                          cursorColor: primaryColor,
                          //     selectionControls:
                          //           CustomTextSelectionControls(color: primaryColor),
                          keyboardType: TextInputType.none,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 34,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SingleChildScrollView(
                          child: Text(
                            myAnswer,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // height = 1 / 10
              SizedBox(
                height: screenSizeHeight / 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          onBtnTap("backspace");
                        },
                        icon: Icon(
                          Icons.backspace_outlined,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    Divider(
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              // height = 5/ 10

              Wrap(
                  children: Buttons.myButtons
                      .map(
                        (element) => SizedBox(
                          height: ((screenSizeHeight) * 5 / 10) / 5,
                          width: element == "0"
                              ? (screenSize.width - 20) * 1 / 2
                              : (screenSize.width - 20) * 1 / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: GestureDetector(
                              onTap: () {
                                onBtnTap(element);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.black26
                                          : Colors.grey[500]!,
                                      offset: const Offset(10, 5),
                                      blurRadius: 5,
                                    )
                                  ],
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryColor.withOpacity(0.2),
                                      btnColor(element),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    element,
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  Color btnColor(String value) {
    if (Buttons.numbers.contains(value)) {
      if (themeModeNotifier.value == ThemeMode.dark) {
        return Colors.white;
      }
      return secondaryColor;
    }

    return primaryColor;
  }

  void onBtnTap(String value) {
    if (value == "C") {
      myInput.text = "";
      setState(() {
        myAnswer = "0";
      });
      return;
    }
    if (value == "backspace") {
      if (myInput.text.isNotEmpty) {
        position = myInput.selection.baseOffset;
        myInput.text = myInput.text.substring(0, position - 1) +
            myInput.text.substring(position);
        myInput.selection = TextSelection.fromPosition(
          TextPosition(offset: position - 1),
        );
      }
      return;
    }
    if (value == "=") {
      if (myInput.text.isEmpty) {
        return;
      }

      expressionCleaned = myInput.text.replaceAll(RegExp(r'\s+'), '');

      MathematicalExpressionEvaluation parser =
          MathematicalExpressionEvaluation(expressionCleaned);

      if (!parser.Z()) {
        setState(() {
          myAnswer = "Incorrect Expression";
        });
        return;
      }

      List<String> postfix = infixToPostfix(myInput.text);
      double result = evaluatePostfixExpression(postfix);
      setState(() {
        myAnswer = result.toString();
      });

      return;
    }
    if (focusNode.hasFocus) {
      position = myInput.selection.baseOffset;
      myInput.text = myInput.text.substring(0, position) +
          value +
          myInput.text.substring(position);

      myInput.selection = TextSelection.fromPosition(
        TextPosition(offset: position + 1),
      );
    }

    return;
  }
}
