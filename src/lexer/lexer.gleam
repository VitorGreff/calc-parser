import gleam/io
import gleam/string

type Token {
  Operator(String)
  Digit(Float)
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

pub fn run_lexer(tokens_str: String) {
  let token_list = string.split(tokens_str, on: " ")
  case check_consecutive_operators(token_list, False) {
    True -> io.println_error("No support for consecutive operators")
    False -> todo
  }
}
