# SHELLCHECK

[![BuyMeCoffee][buymecoffeebedge]][buymecoffee]

_Run shellcheck on ALL sh files in the repository._

## Example

```
workflow "Shellcheck" {
  on = "push"
  resolves = [
    "Shellcheck",
  ]
}


action "Shellcheck" {
  uses = "ludeeus/actions/shellcheck@master"
}
```

[buymecoffee]: https://www.buymeacoffee.com/ludeeus
[buymecoffeebedge]: https://camo.githubusercontent.com/cd005dca0ef55d7725912ec03a936d3a7c8de5b5/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6275792532306d6525323061253230636f666665652d646f6e6174652d79656c6c6f772e737667
