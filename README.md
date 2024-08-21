# actions.vim

Shortcut action list powered by `fzf` fuzzy-finding. Offshore cognitive effort into a persistent, project-specific list of repeating actions. 

Common use cases include:

- Go to faraway files: $HOME config files, headers down /usr/share, that repo you're basing your project off...
- Execute arbitrary vim commands (including shell commands)
- Update and source an action list tailored to your current project


## Installation

This plugin requires you to have [fzf.vim](https://github.com/junegunn/fzf.vim) first.

Install using vim-plug:

```
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug pabsan-0/vim-actions
```

## Usage 

If unused, the plugin will set `<leader>q` as default mapping to call the action list.

The point of this plugin is speed, nonetheless you can also call it via the slower `:Actions`. 


## System-wide actions

Your personal default list of actions can be defined in your `~/.vimrc` by setting the variable `g:actions_list`. The plugin default is as follows:

https://github.com/pabsan-0/vim-actions/blob/be959d1c19b96d1a045689af41ff32f6039e9df5/plugin/shortcuts.vim#L12-L19
 
About action lists: 

- Notice the usage of the `|` to separate action names and targets.
- Lines will be displaying in reverse, i.e top-to-bottom, in the fzf menu.
- Empty lines are to make chunks out of the actions, and will reflect on the fzf menu.


## Project-wise actions

For project-specific actions, use a local `.vimrc` file at the root of your project that updates `g:actions_list`.

For maximum convenience, your default action list should include an action to source this file. An extra custom mapping to handle this file is not recommended, since it only gives you more stuff to think about.

Here's a few examples on how this file may look like.

https://github.com/pabsan-0/vim-actions/blob/be959d1c19b96d1a045689af41ff32f6039e9df5/samples/.vimrc-extend#L4-L10

https://github.com/pabsan-0/vim-actions/blob/be959d1c19b96d1a045689af41ff32f6039e9df5/samples/.vimrc-replace#L4-L7

