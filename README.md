# typst-git-info

Typst package for reading basic Git metadata directly from `.git` reflog and HEAD.

## Usage

```typst
#import "src/lib.typ": git-branch, git-head-hash, git-last-commit, git-format-date

#let branch = git-branch()
#let hash = git-head-hash()
#let last = git-last-commit()

branch: #branch \
head: #hash \
last message: #last.message \
last date (raw): #last.date \
last date: #(git-format-date(last.date))
```

## Notes

- Commit message/date come from `.git/logs/HEAD` (reflog). The date is stored as `unix_timestamp timezone`, e.g. `1768468178 +0100`, and can be formatted via `git-format-date`.
- The package reads files; it does not run Git commands or modify the repository.
