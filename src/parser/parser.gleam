import gleam/int
import types/types

pub fn parse(
  tokens: List(types.Token),
  operator: String,
  curr_digit: String,
  result: Int,
) -> Int {
  case tokens {
    [h, ..t] ->
      case h, operator, curr_digit {
        types.Token(types.Digit, value), "", "" -> parse(t, "", value, result)
        types.Token(types.Digit, value), op, "" -> parse(t, op, value, result)
        types.Token(types.Digit, _value), "", _digit ->
          panic as "invalid expression -> two numbers without operator"
        types.Token(types.Digit, value), op, digit -> {
          let aux = parse_binary_expression(op, digit, value)
          parse(t, "", int.to_string(aux), aux)
        }
        types.Token(types.Operator, _op), _, "" ->
          panic as "invalid expression -> operator without left digit"
        types.Token(types.Operator, op), "", digit ->
          parse(t, op, digit, result)
        types.Token(types.Operator, _op), _curr_op, _digit ->
          panic as "invalid expression -> two operators without any digits"
      }
    [] -> result
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
