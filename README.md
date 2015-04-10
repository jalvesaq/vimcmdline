# vimcmdline: Send lines to interpreter

## How to install

Copy the directories *ftplugin* and *plugin* and their files to your *~/.nvim*
directory, or use a plugin manager.

## Usage 

If you are editing one of the supported file types (haskell, julia, lisp,
matlab, python, ruby or sh), in Normal mode do:

  - `<LocalLeader>s` to start the interpreter.

  - `<Space>` to send the current line to the interpreter.

  - `<LocalLeader>q` to send the quit command to the interpreter.

For languages that can source chunks of code, in Visual mode, press:

  - `<Space>` to send a selection of text to the interpreter

  - `<LocalLeader>f` to send the entire file to the interpreter.

## Options

Below are examples of how to set the options in your *nvimrc*:

```vim
let vimcmdline_vsplit = 1        " Split the window vertically
let vimcmdline_esc_term = 1      " Remap <Esc> to :stopinsert in Neovim terminal
let vimcmdline_in_buffer = 0     " Start the interpreter in a Neovim buffer
let vimcmdline_term_height = 15  " Initial height of interpreter window or pane
let vimcmdline_term_width = 80   " Initial width of interpreter window or pane
let vimcmdline_tmp_dir = '/tmp'  " Temporary directory to save files
let vimcmdline_outhl = 1         " Syntax highlight the output
```

You can also set the foreground colors of the interpreter output in your *nvimrc*.
The example below is for a terminal emulator that supports 256 colors (see in
Vim `:h highlight-ctermfg`:

```vim
if &t_Co == 256
    let cmdline_color_input = 247
    let cmdline_color_normal = 39
    let cmdline_color_number = 51
    let cmdline_color_integer = 51
    let cmdline_color_float = 51
    let cmdline_color_complex = 51
    let cmdline_color_negnum = 183
    let cmdline_color_negfloat = 183
    let cmdline_color_date = 43
    let cmdline_color_true = 78
    let cmdline_color_false = 203
    let cmdline_color_inf = 39
    let cmdline_color_constant = 75
    let cmdline_color_string = 79
    let cmdline_color_stderr = 33
    let cmdline_color_error = 15
    let cmdline_color_warn = 1
    let cmdline_color_index = 186
endif
```

To know what number corresponds to your preferred color (among the 256
possibilities), hover you mouse pointer over the table of colors at the end
of http://www.lepem.ufc.br/jaa/colorout.html

If you prefer that the output is highlighted using you current `colorscheme`,
put in your *nvimrc*:

```vim
let cmdline_follow_colorscheme = 1
```
