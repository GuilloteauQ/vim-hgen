# Vim-HGen
Generate your header files from Vim

## How to run ?

To run the pluggin, enter the command

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
