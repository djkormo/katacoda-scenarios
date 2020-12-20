
Examples how to start:

Using copy and paste in vim

Cut and paste:

    Position the cursor where you want to begin cutting.
    Press v to select characters, or uppercase V to select whole lines, or Ctrl-v to select rectangular blocks (use Ctrl-q if Ctrl-v is mapped to paste).
    Move the cursor to the end of what you want to cut.
    Press d to cut (or y to copy).
    Move to where you would like to paste.
    Press P to paste before the cursor, or p to paste after.

Copy and paste is performed with the same steps except for step 4 where you would press y instead of d:

    d stands for delete in Vim, which in other editors is usually called cut
    y stands for yank in Vim, which in other editors is usually called 
    

https://vim.fandom.com/wiki/Copy,_cut_and_paste