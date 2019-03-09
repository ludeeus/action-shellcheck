workflow "Trigger: Push" {
  on = "push"
  resolves = [
    "Shellcheck",
    "Black Code Formatter",
  ]
}

action "Shellcheck" {
  uses = "ludeeus/action-shellcheck@master"
}

action "Black Code Formatter" {
  uses = "lgeiger/black-action@master"
  args = "$GITHUB_WORKSPACE --check"
}