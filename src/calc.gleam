import gleam/io
import lexer/lexer

pub fn main() {
  lexer.run_lexer("1.0 + 3.0 - 4.0 / 5.0")
  |> io.debug
}
