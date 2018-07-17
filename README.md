# vimcmdline: Send lines to interpreter

This plugin sends lines from either [Vim] or [Neovim] to a command line
interpreter (REPL application). Supported file types are Golang, Haskell,
JavaScript, Julia, Jupyter, Lisp, Macaulay2, Matlab, Prolog, Python, Ruby,
Sage, and sh. The interpreter may run in a Neovim built-in terminal (Neovim
buffer), an external terminal emulator or in a tmux pane. The main advantage
of running the interpreter in a Neovim terminal is that the output is
colorized, as in the screenshot below, where we have different colors for
general output, positive and negative numbers, and the prompt line:

![nvim_running_octave](https://cloud.githubusercontent.com/assets/891655/7090493/5fba2426-df71-11e4-8eb8-f17668d9361a.png)

If running in either a Neovim built-in terminal or an external terminal, the
plugin runs one instance of the REPL application for each file type. If
running in a tmux pane, it runs one REPL application for Vim instance.

## How to install

Copy the directories `ftplugin`, `plugin` and `syntax` and their files to your
`~/.vim` or `~/.config/nvim` directory, or use a plugin manager such as
[Vim-Plug], [Vundle], [Pathogen], [Neobundle], or other.

## Usage

If you are editing one of the supported file types, in Normal mode do:

  - `<LocalLeader>s` to start the interpreter.

  - `<Space>` to send the current line to the interpreter.

  - `<LocalLeader><Space>` to send the current line to the interpreter and keep the cursor on the current line.

  - `<LocalLeader>q` to send the quit command to the interpreter.

For languages that can source chunks of code:

  - In Visual mode, press:

    - `<Space>` to send a selection of text to the interpreter.

  - And, in Normal mode, press:

    - `<LocalLeader>p` to send from the line to the end of paragraph.

    - `<LocalLeader>b` to send block of code between the two closest marks.

    - `<LocalLeader>f` to send the entire file to the interpreter.

## Options

Below are examples of how to set the options in your `vimrc`:

```vim
" vimcmdline mappings
let cmdline_map_start          = '<LocalLeader>s'
let cmdline_map_send           = '<Space>'
let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
let cmdline_map_source_fun     = '<LocalLeader>f'
let cmdline_map_send_paragraph = '<LocalLeader>p'
let cmdline_map_send_block     = '<LocalLeader>b'
let cmdline_map_quit           = '<LocalLeader>q'

" vimcmdline options
let cmdline_vsplit      = 1      " Split the window vertically
let cmdline_esc_term    = 1      " Remap <Esc> to :stopinsert in Neovim's terminal
let cmdline_in_buffer   = 1      " Start the interpreter in a Neovim's terminal
let cmdline_term_height = 15     " Initial height of interpreter window or pane
let cmdline_term_width  = 80     " Initial width of interpreter window or pane
let cmdline_tmp_dir     = '/tmp' " Temporary directory to save files
let cmdline_outhl       = 1      " Syntax highlight the output
let cmdline_auto_scroll = 1      " Keep the cursor at the end of terminal (nvim)
```

You can also define what application will be run as interpreter for each
supported file type. If you want to do this, create a dictionary called
`cmdline_app`, and add items with the 'filetype' as key and the interpreter as
value, as in the example below:

```vim
let cmdline_app           = {}
let cmdline_app['python'] = 'ptipython3'
let cmdline_app['ruby']   = 'pry'
let cmdline_app['sh']     = 'bash'
```

If you are using Neovim, you can use its syntax highlight capabilities to
colorize the interpreter output, and you can customize the colors in your
`vimrc` in three different ways:

  1. The hex code of the foreground color.

  2. The ANSI number of the foreground color.

  3. The complete highlighting specification.

The example of customization below will work if either your editor supports
true colors or if it supports 256 colors (see in Neovim `:h tui-colors`):

```vim
if has('gui_running') || &termguicolors
    let cmdline_color_input    = '#9e9e9e'
    let cmdline_color_normal   = '#00afff'
    let cmdline_color_number   = '#00ffff'
    let cmdline_color_integer  = '#00ffff'
    let cmdline_color_float    = '#00ffff'
    let cmdline_color_complex  = '#00ffff'
    let cmdline_color_negnum   = '#d7afff'
    let cmdline_color_negfloat = '#d7afff'
    let cmdline_color_date     = '#00d7af'
    let cmdline_color_true     = '#5fd787'
    let cmdline_color_false    = '#ff5f5f'
    let cmdline_color_inf      = '#00afff'
    let cmdline_color_constant = '#5fafff'
    let cmdline_color_string   = '#5fd7af'
    let cmdline_color_stderr   = '#0087ff'
    let cmdline_color_error    = '#ff0000'
    let cmdline_color_warn     = '#c0ffff'
    let cmdline_color_index    = '#d7d787'
elseif &t_Co == 256
    let cmdline_color_input    = 247
    let cmdline_color_normal   =  39
    let cmdline_color_number   =  51
    let cmdline_color_integer  =  51
    let cmdline_color_float    =  51
    let cmdline_color_complex  =  51
    let cmdline_color_negnum   = 183
    let cmdline_color_negfloat = 183
    let cmdline_color_date     =  43
    let cmdline_color_true     =  78
    let cmdline_color_false    = 203
    let cmdline_color_inf      =  39
    let cmdline_color_constant =  75
    let cmdline_color_string   =  79
    let cmdline_color_stderr   =  33
    let cmdline_color_error    =  15
    let cmdline_color_warn     =   1
    let cmdline_color_index    = 186
endif
```

And the next example sets the value of an option as the complete highlighting
specification.

```vim
let cmdline_color_error = 'ctermfg=1 ctermbg=15 guifg=#c00000 guibg=#ffffff gui=underline term=underline'
```

If you prefer that the output is highlighted using you current `colorscheme`,
put in your `vimrc`:

```vim
let cmdline_follow_colorscheme = 1
```

Finally, if you want to run the interpreter in an external terminal emulator,
you have to define the command to run it, as in the examples below:

```vim
let cmdline_external_term_cmd = "gnome-terminal -e '%s'"
let cmdline_external_term_cmd = "xterm -e '%s' &"
```

where `%s` will be replaced with the terminal command required to run the REPL
application in a tmux session. Note that `gnome-terminal` does not require an
`&` at the end of the command because it forks immediately after startup.

Your `~/.inputrc` should not include `set keymap vi` because it would cause
some applications to start in vi's edit mode. Then, you would always have to
press either `a` or `i` in the interpreter console before using it.


## See also

Plugins with similar functionality are [neoterm], [vim-slime] and [repl.nvim].

[neoterm]: https://github.com/kassio/neoterm
[Vim]: http://www.vim.org
[Neovim]: https://github.com/neovim/neovim
[Vundle]: https://github.com/gmarik/Vundle.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
[Vim-Plug]: https://github.com/junegunn/vim-plug
[Neobundle]: https://github.com/Shougo/neobundle.vim
[vim-slime]: https://github.com/jpalardy/vim-slime
[repl.nvim]: https://gitlab.com/HiPhish/repl.nvim
