import gleam/io
import lexer/lexer
import parser/parser

pub fn main() {
  lexer.run_lexer("( 8.0 / ( 4.0 - ( 1.0 + 1.0 ) ) ) + 3.0")
  |> io.debug
  |> parser.run_parser()
  |> io.debug
}
