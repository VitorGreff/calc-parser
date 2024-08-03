import argv
import gleam/io
import gleam/list
import gleam/string
import lexer/lexer
import parser/parser

pub fn main() {
  let expressions = argv.load().arguments
  list.each(expressions, fn(expression) {
    string.split(expression, "")
    |> lexer.tokenize([], "")
    // |> parser.parse("", "")
    // |> io.debug
  })
}
