pub type Token {
  Token(token_type: TokenType, value: String)
}

pub type TokenType {
  Digit
  Operator
}
