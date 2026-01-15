#import "src/lib.typ": git-branch, git-head-hash, git-last-commit, git-log

= Git Metadata Showcase

This file demonstrates the `git-info` helpers. It reads branch and hash from `.git` and optionally uses `git-meta.toml` for message/date.

#let branch = git-branch()
#let hash = git-head-hash()
#let last = git-last-commit(meta_path: "git-meta.toml")

* Branch: #branch
* HEAD hash: #hash
* Last message: #last.message
* Last date: #last.date

== Commit list

If you created `git-log.txt` using `git log -5 --date=iso-strict --format='%H|%cI|%s' > git-log.txt`, you can parse it:

#let commits = git-log("git-log.txt")

#table(
  columns: 3,
  [Hash], [Date], [Message],
  ..commits.map(c => (c.hash, c.date, c.message)).flatten(),
)