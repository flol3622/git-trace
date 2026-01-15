// Git metadata helpers for Typst.

#let _git-head(git_dir: ".git") = read(git_dir + "/HEAD").trim()

#let _at(arr, i, default: none) = {
  if i < 0 or i >= arr.len() { default } else { arr.at(i) }
}

#let _git-reflog-last(git_dir: ".git") = {
  let lines = read(git_dir + "/logs/HEAD").split("\n")
  lines.filter(line => line.trim() != "").last(default: none)
}

#let git-head-ref(git_dir: ".git") = {
  let head = _git-head(git_dir: git_dir)
  if head.starts-with("ref: ") { head.replace("ref: ", "") } else { none }
}

#let git-branch(git_dir: ".git") = {
  let ref = git-head-ref(git_dir: git_dir)
  if ref == none { none } else { ref.split("/").last(default: none) }
}

#let git-head-hash(git_dir: ".git") = {
  let line = _git-reflog-last(git_dir: git_dir)
  if line == none { none } else {
    let left = _at(line.split("\t"), 0, default: "")
    let parts = left.split(" ")
    _at(parts, 1, default: none)
  }
}

#let git-last-commit(git_dir: ".git") = {
  let line = _git-reflog-last(git_dir: git_dir)
  if line == none { (branch: none, hash: none, message: none, date: none) } else {
    let branch = git-branch(git_dir: git_dir)
    let chunks = line.split("\t")
    let left = _at(chunks, 0, default: "")
    let message = _at(chunks, 1, default: none)
    let parts = left.split(" ")
    let hash = _at(parts, 1, default: none)
    let ts = _at(parts, parts.len() - 2, default: none)
    let tz = _at(parts, parts.len() - 1, default: none)
    let date = if ts == none or tz == none { none } else { ts + " " + tz }
    (branch: branch, hash: hash, message: message, date: date)
  }
}
