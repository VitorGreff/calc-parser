import gleam/int
import gleam/io
import gleam/list
import gleam/string
import types/types

pub fn tokenize(
  exp: List(String),
  token_list: List(types.Token),
  curr_number: String,
) -> List(types.Token) {
  case exp {
    [h, ..t] ->
      case int.parse(h) {
        Ok(_) -> {
          tokenize(t, token_list, string.append(curr_number, h))
        }
        Error(_) -> {
          case list.contains(["+", "-", "*", "/"], h) {
            True -> {
              case string.length(curr_number) {
                0 -> {
                  tokenize(
                    t,
                    list.append(token_list, [types.Token(types.Operator, h)]),
                    curr_number,
                  )
                }
                _ -> {
                  tokenize(
                    t,
                    list.append(token_list, [
                      types.Token(types.Digit, curr_number),
                      types.Token(types.Operator, h),
                    ]),
                    "",
                  )
                }
              }
            }
            False -> panic as "invalid character was passed as an argument"
          }
        }
      }
    [] -> {
      case string.length(curr_number) {
        0 -> {
          let assert Ok(last) = list.last(token_list)
          case last {
            types.Token(types.Digit, _) -> token_list
            types.Token(types.Operator, _) ->
              panic as "expression ended with an operator"
          }
        }
        _ -> {
          list.append(token_list, [types.Token(types.Digit, curr_number)])
          |> io.debug
        }
      }
    }
  }
}
