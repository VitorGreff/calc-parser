pub type Token {
  Operator(String)
  Digit(Float)
}

pub type Precedence {
  Low
  Medium
  High
}
