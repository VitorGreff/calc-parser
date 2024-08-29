# calc
## Observations
- Currently, only floating point operations are supported, for practical reasons, so the following expression wont work:
> 5 - 9 / 2

- To correctly tokenize each lexeme, all character must be spaced, parentheses included.
    - 3*(2-1) -> invalid input
    - 3.0 * ( 2.0 - 1.0 ) -> valid input

```sh
gleam run   # Run the project
```
