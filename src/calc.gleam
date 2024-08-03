import argv
import gleam/io
import gleam/list
import gleam/string
import lexer/lexer

pub fn main() {
  let expressions = argv.load().arguments
  list.each(expressions, fn(expression) {
    string.split(expression, "")
    |> lexer.tokenize([], "")
    |> io.debug
  })
}
