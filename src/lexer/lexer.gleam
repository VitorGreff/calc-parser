import gleam/int
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
          tokenize(
            t,
            list.append(token_list, [
              types.Token(types.Digit, string.append(curr_number, h)),
            ]),
            string.append(curr_number, h),
          )
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
                    list.append(token_list, [types.Token(types.Operator, h)]),
                    "",
                  )
                }
              }
            }
            False -> panic as "invalid character was passed as an argument"
          }
        }
      }
    [] -> token_list
  }
}
