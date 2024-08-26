import gleam/io
import lexer/lexer
import parser/parser

pub fn main() {
  lexer.run_lexer("3.14 * 2.0 + 10.5 / 2.1 - 4.2 * 3.0 + 7.7")
  |> io.debug
  |> parser.run_parser()
  |> io.debug
}
