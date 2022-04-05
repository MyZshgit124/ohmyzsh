<<<<<<< HEAD
## Coffeescript Plugin

This plugin provides aliases for quickly compiling and previewing your
cofeescript code.
=======
# Coffeescript Plugin

This plugin provides aliases for quickly compiling and previewing your
coffeescript code.
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b

When writing Coffeescript it's very common to want to preview the output of a
certain snippet of code, either because you want to test the output or because
you'd like to execute it in a browser console which doesn't accept Coffeescript.

Preview the compiled result of your coffeescript with `cf "code"` as per the
following:

```zsh
<<<<<<< HEAD
$ cf 'if a then be else c'
=======
$ cf 'if a then b else c'
>>>>>>> 4d9e5ce9a7d8db3c3aadcae81580a5c3ff5a0e8b
if (a) {
  b;
} else {
  c;
}
```

Also provides the following aliases:

* **cfc:** Copies the compiled JS to your clipboard. Very useful when you want
           to run the code in a JS console.

* **cfp:** Compiles from your currently copied clipboard. Useful when you want 
           to compile large/multi-line snippets

* **cfpc:** Paste coffeescript from clipboard, compile to JS, then copy the
            the result back to clipboard.
