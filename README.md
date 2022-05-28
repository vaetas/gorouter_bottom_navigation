# go_router Bottom Navigation Example

Example implementation of Bottom Navigation Architecture using go_router package. Individual tabs
are lazily built and their state is persisted. All currently inactive tabs have their animations
disabled and are wrapped in the `Offstage` Widget.

There is also very simple implementation of user login. This utilizes `riverpod` and redirection
using `go_router`.