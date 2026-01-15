#import "src/lib.typ": git-branch, git-head-hash, git-last-commit, git-format-date

= Git Metadata Showcase

This file demonstrates the `git-info` helpers. It reads branch, hash, message, and date from `.git` reflog.

#let git_dir = "../.git"
#let branch = git-branch(git_dir: git_dir)
#let hash = git-head-hash(git_dir: git_dir)
#let last = git-last-commit(git_dir: git_dir)

- Branch: #branch
- HEAD hash: #hash
- Last message: #last.message
- Last date (raw): #last.date
- Last date: #(git-format-date(last.date))
