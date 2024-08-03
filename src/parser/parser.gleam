import gleam/int
import types/types

pub fn parse(
  tokens: List(types.Token),
  operator: String,
  curr_digit: String,
) -> Int {
  case tokens {
    [h, ..t] ->
      case h, operator, curr_digit {
        types.Token(types.Digit, value), "", "" -> parse(t, "", value)
        types.Token(types.Digit, value), op, "" -> parse(t, op, value)
        types.Token(types.Digit, _value), "", _digit ->
          panic as "invalid expression -> two numbers without operator"
        types.Token(types.Digit, value), op, digit ->
          parse_binary_expression(op, digit, value)
        types.Token(types.Operator, _op), _, "" ->
          panic as "invalid expression -> operator without left digit"
        types.Token(types.Operator, op), "", digit -> parse(t, op, digit)
        types.Token(types.Operator, _op), _curr_op, _digit ->
          panic as "invalid expression -> two operators without any digits"
      }
    [] -> panic as "empty token list"
  }
}

fn parse_binary_expression(op: String, left: String, right: String) -> Int {
  let assert Ok(left) = int.parse(left)
  let assert Ok(right) = int.parse(right)
  case op {
    "+" -> left + right
    "-" -> left - right
    "*" -> left * right
    "/" -> left / right
    _ -> panic as "unknown error"
  }
}
// fn parse_factor()
//
// fn get_next_token(
//   tokens: List(types.Token),
// ) -> #(types.Token, List(types.Token)) {
//   let assert Ok(tail) = list.rest(tokens)
//   let assert Ok(head) = list.first(tokens)
//   #(head, tail)
// }
