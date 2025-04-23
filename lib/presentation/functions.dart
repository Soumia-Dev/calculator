import 'package:stack/stack.dart ' as stk;

// calculateFunctions-----------------------------------------------------------------------

// subFunction---
bool isOperator(String c) {
  return c == '+' || c == '-' || c == '*' || c == '/';
}

int gradeOperator(String op) {
  if (op == '+' || op == '-') {
    return 1;
  } else if (op == '*' || op == '/') {
    return 2;
  }
  return 0;
}

double applyOperator(double a, double b, String operator) {
  switch (operator) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      return a / b;
    default:
      return 0.0;
  }
}

// calculate---
List<String> infixToPostfix(String infixExpression) {
  List<String> postfixExpression = [];
  stk.Stack<String> stack = stk.Stack<String>();
  String token;
  RegExp regExp = RegExp(r"(\d+(\.\d+)?|[*/()+\-])");
  List<String> infixTokens = regExp
      .allMatches(infixExpression)
      .map((match) => match.group(0)!)
      .toList();

  for (int i = 0; i < infixTokens.length; i++) {
    token = infixTokens[i];
    if ((token == "-" || token == "+") &&
        (i == 0 ||
            isOperator(infixTokens[i - 1]) ||
            infixTokens[i - 1] == "(")) {
      i = i + 1;
      postfixExpression.add(token + infixTokens[i]);
    } else if (!isOperator(token) && token != "(" && token != ")") {
      postfixExpression.add(token);
    } else if (token == "(") {
      stack.push(token);
    } else if (token == ")") {
      while (stack.isNotEmpty && stack.top() != "(") {
        postfixExpression.add(stack.pop());
      }
      if (stack.isNotEmpty && stack.top() == "(") {
        stack.pop(); // Discard the '('
      } // Discard the '('
    } else if (isOperator(token)) {
      while (stack.isNotEmpty &&
          gradeOperator(stack.top().toString()) >= gradeOperator(token)) {
        postfixExpression.add(stack.pop());
      }
      stack.push(token);
    }
  }

  while (stack.isNotEmpty) {
    postfixExpression.add(stack.pop());
  }

  return postfixExpression;
}

double evaluatePostfixExpression(List postfixExpression) {
  stk.Stack<double> stack = stk.Stack();

  for (String token in postfixExpression) {
    if (!isOperator(token)) {
      stack.push(double.parse(token));
    } else {
      double operand2 = stack.pop();
      double operand1 = stack.pop();
      double result = applyOperator(operand1, operand2, token);
      stack.push(result);
    }
  }
  return stack.pop();
}
// Mathematical expression evaluation-------------------------------------------------------

class MathematicalExpressionEvaluation {
  // Z → S
  // S → T ((O T)*)?
  // T → N | (S)
  // N → RegExp(r'[-+]?\d+(.\d+)?')
  // O → + | - | * | /

  final String input;
  int position = 0;

  MathematicalExpressionEvaluation(this.input);

// Z → S
  bool Z() {
    bool result = S();
    return (result && position == input.length);
  }

// S → T (O T)* .....T|TOT|TOTOT|TOTOTOT|...
  bool S() {
    if (!T()) return false;

    while (O()) {
      if (!T()) return false;
    }

    return true;
  }

  // T → N | (S)
  bool T() {
    if (peek() == '(') {
      position++; // Consume '('
      if (!S()) return false;
      if (peek() != ')') return false;
      position++; // Consume ')'
      return true;
    } else {
      return N();
    }
  }

  // N → RegExp(r'[-+]?\d+(\.\d+)?')
  bool N() {
    final regex = RegExp(r'([-+]?\d+(\.\d+)?)');
    final match = regex.matchAsPrefix(input, position);
    if (match != null) {
      position += match.group(0)!.length; // Consume the matched number
      return true;
    }
    return false;
  }

  // O → + | - | * | /
  bool O() {
    if (position < input.length && '+-*/'.contains(input[position])) {
      position++; // Consume operator
      return true;
    }
    return false;
  }

  String? peek() {
    return position < input.length ? input[position] : null;
  }
}
