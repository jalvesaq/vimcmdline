# vimcmdline: Send lines to interpreter

This plugin sends lines from either [Vim] or [Neovim] to a command line
interpreter (REPL application). There is support for
Clojure, Golang, Haskell, JavaScript, Julia, Jupyter, Kotlin, Lisp, Lua, Macaulay2, Matlab,
Prolog, Python, Racket, Ruby, Sage, Scala, Shell script, Swift, Kdb/q and TypeScript
(see [Nvim-R](https://github.com/jalvesaq/Nvim-R) for R support on
Vim/Neovim). The interpreter runs in Neovim's built-in terminal.
If Tmux is installed, the interpreter can also run in
an external terminal emulator or in a tmux pane. The main advantage
of running the interpreter in a Neovim terminal is that the output is
colorized, as in the screenshot below, where we have different colors for
general output, positive and negative numbers, and the prompt line:

![nvim running octave](https://cloud.githubusercontent.com/assets/891655/7090493/5fba2426-df71-11e4-8eb8-f17668d9361a.png)

If running in either a Neovim built-in terminal or an external terminal, the
plugin runs one instance of the REPL application for each file type. If
running in a tmux pane, it runs one REPL application for Vim instance.

Support for running the interpreter in Vim's built-in terminal was not
implemented.
I have never adapted the plugin to run the interpreter within Vim's built-in
terminal (as it does in Neovim) because Vim cannot colorize the output printed
in its terminal.

## How to install

Use a plugin manager to install vimcmdline.

You have to install Tmux if you either want to run the interpreter in an
external terminal emulator or are using Vim.


## Usage and options

Please, read the plugin's
[documentation](https://raw.githubusercontent.com/jalvesaq/vimcmdline/master/doc/vimcmdline.txt)
for further instructions.


## How to add support for a new language

  1. Look at the Vim scripts in the `ftplugin` directory and make a copy of
     the script supporting the language closer to the language that you want
     to support.

  2. Save the new script with the name "filetype\_cmdline.vim" where
     "filetype" is the output of `echo &filetype` when you are editing a
     script of the language that you want to support.

  3. Edit the new script and change the values of its variables as necessary.

  4. Test your new file-type script by running your application in either Vim
     or Neovim and using either the built-in terminal or a Tmux split pane.

  5. Look at the Vim scripts in the `syntax` directory and make a copy of the
     script supporting the language whose output is closer to the output of
     the language that you want to support.

  6. Save the new script with the name "cmdlineoutput\_app.vim" where "app" is
     the name of the interpreter. For example, for the "matlab" file-type, the
     interpreter is "octave".

  7. Edit the new script and change both the pattern used to recognize the
     input line and the pattern used to recognize errors.

  8. Test your new syntax highlighting script by running your application in a
     Neovim built-in terminal.

## See also

Plugins with similar functionality are [vim-slime] and [neoterm].

[Vim]: http://www.vim.org
[Neovim]: https://github.com/neovim/neovim
[vim-slime]: https://github.com/jpalardy/vim-slime
[neoterm]: https://github.com/kassio/neoterm
