
import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
  oni.input.unbind("<c-g>") // make C-g work as expected in vim
  oni.input.unbind("<c-v>") // make C-v work as expected in vim
  oni.input.bind("<s-c-g>", () => oni.commands.executeCommand("sneak.show")) // You can rebind Oni's behaviour to a new keybinding
}

export const configuration = {
    activate,
    "oni.hideMenu"             : "hidden", // Hide top bar menu
    "oni.loadInitVim"          : true, // Load user's init.vim
    "oni.useDefaultConfig"     : false, // Do not load Oni's init.vim
    "ui.colorscheme"           : "n/a", // Load init.vim colorscheme
    "autoClosingPairs.enabled" : false, // disable autoclosing pairs
    "commandline.mode"         : false, // Do not override commandline UI
    "wildmenu.mode"            : false, // Do not override wildmenu UI,
    "tabs.mode"                : "native", // Use vim's tabline
    "sidebar.enabled"          : false, // sidebar ui is gone
    "sidebar.default.open"     : false, // the side bar collapse 
    "learning.enabled"         : false, // Turn off learning pane
    "achievements.enabled"     : false, // Turn off achievements tracking / UX
    "editor.typingPrediction"  : false, // Wait for vim's confirmed typed chars
    // "editor.textMateHighlighting.enabled" : false, // Use vim syntax highlighting
}
