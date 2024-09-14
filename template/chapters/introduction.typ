#import "global.typ": *

This is a test for bibilography @QayyumY-sac2022. The introduction should be more in-depth than the abstract. The first time it's the long one @uit, but the second time it's the short one @uit.

#figure(caption: [Hello world! in rust])[
  ```rust
  pub fn main() {
    println!("Hello, world!");
  }
  ```
] <raw:rust>

@raw:rust is a simple rust code snippet.

```fsi
[<EntryPoint>]
let main () =
  "Hello, world!"
  |> printfn
```

```c
int main() {
  printf("Hello, world!");
  return(0);
}
```

```python
if __name__ == "__main__":
  print("Hello, world!")
```

For more information take a look at the repo #footnote[see #link("https://github.com/mrtz-j/typst-thesis-template")]

1st, 2nd, 3rd, 4th

#lorem(100)
