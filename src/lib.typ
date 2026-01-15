// Git metadata helpers for Typst.

#let _git-head(git_dir: ".git") = read(git_dir + "/HEAD").trim()

#let git-head-ref(git_dir: ".git") = {
  let head = _git-head(git_dir: git_dir)
  if head.starts-with("ref: ") { head.replace("ref: ", "") } else { none }
}

#let git-branch(git_dir: ".git") = {
  let ref = git-head-ref(git_dir: git_dir)
  if ref == none { none } else { ref.split("/").last(default: none) }
}

#let git-ref-hash(ref, git_dir: ".git") = read(git_dir + "/" + ref).trim()

#let git-head-hash(git_dir: ".git") = {
  let head = _git-head(git_dir: git_dir)
  if head.starts-with("ref: ") {
    let ref = head.replace("ref: ", "")
    git-ref-hash(ref, git_dir: git_dir)
  } else { head }
}

#let git-meta(path) = toml(path)

#let git-last-commit(meta_path: none, git_dir: ".git") = {
  let meta = if meta_path == none { none } else { toml(meta_path) }
  let hash = git-head-hash(git_dir: git_dir)
  let branch = git-branch(git_dir: git_dir)
  let message = if meta == none { none } else { meta.at("message", none) }
  let date = if meta == none { none } else { meta.at("date", none) }
  (branch: branch, hash: hash, message: message, date: date)
}

#let git-log(path, separator: "|") = {
  let lines = read(path).split("\n")
  lines
    .filter(line => line.trim() != "")
    .map(line => {
      let parts = line.split(separator)
      (hash: parts.at(0, none), date: parts.at(1, none), message: parts.at(2, none))
    })
}