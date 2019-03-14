workflow "Trigger: Push" {
  on = "push"
  resolves = ["Shellcheck"]
}

action "Shellcheck" {
  uses = "ludeeus/action-shellcheck@master"
}