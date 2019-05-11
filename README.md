# Vim-HGen
Generate your header files from Vim

[![asciicast](https://asciinema.org/a/VLmXqhB2f4DTE2nTJ0gn1Kgei.svg)](https://asciinema.org/a/VLmXqhB2f4DTE2nTJ0gn1Kgei)

## How to install the plugin ?

### Vundle

Add the following line to your ``vimrc``

```vim
Plugin 'GuilloteauQ/vim-hgen'
```

And run ``:PluginInstall``

### Plug 

Add the following line to your ``vimrc``

```vim
Plug 'GuilloteauQ/vim-hgen'
```

And run ``:PlugInstall``

## How to run the Plugin ?

To run the pluggin, enter the following command on a c file

```vim
:Hgen
```

It will open a new buffer with the generated header file.

## Syntax

There is not really much to change to generate the header file.
For elements like structurs, you will need to put the whole ``struct`` definition between two tags:

```c
/* [start]
struct tree {
  int value;
  struct tree* right;
  struct tree* left;
};
[end] */
```

This will copy the content between the two tags in the header file.

## Static functions

``static`` function definitions will not be copied into the header file.
