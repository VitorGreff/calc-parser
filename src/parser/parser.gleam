import gleam/float
import gleam/io
import types/types.{type Token, Digit, Operator}

pub fn run_parser(tokens: List(Token)) -> Float {
  evaluate(tokens, [])
}

fn evaluate(tokens: List(Token), stack: List(Float)) -> Float {
  case tokens {
    [] ->
      case stack {
        [result] -> result
        _ -> panic as "Invalid expression"
      }
    [Digit(d), ..rest] -> evaluate(rest, [d, ..stack])
    [Operator(op), ..rest] -> {
      case stack {
        [right, left, ..remaining_stack] -> {
          let result = apply_operator(op, left, right)
          evaluate(rest, [result, ..remaining_stack])
        }
        _ -> panic as "Not enough operands for operator"
      }
    }
  }
}

fn apply_operator(op: String, a: Float, b: Float) -> Float {
  case op {
    "+" -> float.add(a, b)
    "-" -> float.subtract(a, b)
    "*" -> float.multiply(a, b)
    "/" -> {
      let assert Ok(result) = float.divide(a, b)
      result
    }
    "^" -> {
      let assert Ok(result) = float.power(a, b)
      result
    }
    _ -> {
      io.debug(op)
      panic as "Unknown operator"
    }
  }
}
