# vimcmdline: Send lines to interpreter


## How to install

Copy the directories *ftplugin* and *plugin* and their files to your *~/.vim*
or *~/.nvim* directory, or use a plugin manager.

## Usage 

If you are editing one of the supported file types (julia, lisp, ruby or
haskell, sh, matlab), in Normal mode do:

  - `<LocalLeader>s` to start the interpreter.

  - `<Space>` to send the current line to the interpreter.

  - `<LocalLeader>q` to send the quit command to the interpreter.

For languages that can source chunks of code, in Visual mode, press:

  - `<Space>` to send a selection of text to the interpreter

  - `<LocalLeader>f` to send the entire file to the interpreter.

## Options

Below are examples of how to set the options in your *vimrc*:

```vim
let vimcmdline_vsplit = 1        " Split the window vertically
let vimcmdline_esc_term = 1      " Remap <Esc> to :stopinsert in Neovim terminal
let vimcmdline_in_buffer = 0     " Start the interpreter in a Neovim buffer
let vimcmdline_term_height = 15  " Initial height of interpreter window or pane
let vimcmdline_term_width = 80   " Initial width of interpreter window or pane
let vimcmdline_tmp_dir = '/tmp'  " Temporary directory to save files
```
