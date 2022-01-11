To check the fall-back fonts, run 

```sh
fc-match -s "Fire"
```

Or some similar thing that will not match a real font.  Though evidently this does not work, because the fallback does not seem to match what is used.  Actually, just run this in another terminal

```
alacritty -vvv
```
and it will show you the font that gets loaded.



