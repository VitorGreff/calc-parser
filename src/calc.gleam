import argv
import gleam/io
import gleam/list
import gleam/string
import lexer/lexer

pub fn main() {
  let expression =
    argv.load().arguments
    |> io.debug()
  let assert Ok(first) = list.first(expression)
  io.debug(first)
  lexer.tokenize(string.split(first, ""), [], "")
  |> io.debug()
}
