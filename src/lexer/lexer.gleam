import gleam/float
import gleam/io
import gleam/list
import gleam/string
import types/types.{
  type Precedence, type Token, Digit, High, Low, Medium, Operator,
}

fn precedence(operator: String) -> Precedence {
  case operator {
    "^" -> High
    "*" | "/" -> Medium
    "+" | "-" -> Low
    _ -> panic as "Invalid Operator"
  }
}

// a <= b ?
fn compare_precedence(a: String, b: String) {
  case precedence(a), precedence(b) {
    High, _ -> True
    Medium, Medium -> True
    Medium, Low -> False
    Low, Low -> True
    _, _ -> False
  }
}

fn is_operator(char: String) {
  case char {
    "-" | "+" | "*" | "/" | "^" -> True
    _ -> False
  }
}

// True if so
fn check_consecutive_operators(
  token_list: List(String),
  past_was_operator: Bool,
) -> Bool {
  case token_list, past_was_operator {
    [h, ..], True -> h == "-" || h == "+" || h == "*" || h == "/" || h == "^"
    [h, ..t], False -> check_consecutive_operators(t, is_operator(h))
    [], _ -> False
  }
}

fn handle_operator(
  operator: String,
  stack: List(String),
  exp_output: List(Token),
) {
  case stack {
    [] -> #(list.append([operator], stack), exp_output)
    _ -> {
      let assert Ok(top) = list.first(stack)
      case top {
        "(" -> #(list.append([operator], stack), exp_output)
        ")" -> #(list.append([operator], ["(", ..stack]), exp_output)
        _ -> {
          case compare_precedence(operator, top) {
            False -> #(list.append([operator], stack), exp_output)
            True ->
              handle_operator(
                operator,
                list.drop(stack, 1),
                list.append(exp_output, [Operator(top)]),
              )
          }
        }
      }
    }
  }
}

fn handle_parens(paren: String, stack: List(String), exp_output: List(Token)) {
  case paren {
    "(" -> #(list.append([paren], stack), exp_output)
    ")" ->
      case stack {
        [h, ..t] if h == "(" -> #(t, exp_output)
        [h, ..t] ->
          case is_operator(h) {
            True ->
              handle_parens(
                paren,
                t,
                list.append(exp_output, [Operator(paren)]),
              )
            False -> {
              // not a paranthesis, not an operator
              let assert Ok(value) = float.parse(h)
              handle_parens(paren, t, list.append(exp_output, [Digit(value)]))
            }
          }
        [] -> panic as "Invalid Expression"
      }
    _ -> panic as "Invalid Expression"
  }
}

fn shunting_yard(
  token_list: List(String),
  stack: List(String),
  exp_output: List(Token),
) {
  case token_list {
    [] -> todo
    [h, ..t] ->
      case float.parse(h) {
        Ok(f) -> shunting_yard(t, stack, list.append(exp_output, [Digit(f)]))
        Error(_) ->
          case h {
            _ -> todo
          }
      }
  }
}

pub fn run_lexer(tokens_str: String) {
  let token_list = string.split(tokens_str, on: " ")
  case check_consecutive_operators(token_list, False) {
    True -> io.println_error("No support for consecutive operators")
    False -> todo
  }
}
