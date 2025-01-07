# VS Code and Git

## VS Code

### Julia REPL (read–eval–print loop)

- Open the Command Palette (`Cmd+Maj+P` on macOs or `Ctrl+Maj+P` on Windows, shortcuts below correspond to macOs) 
- Search the command "Julia: Restart REPL", the shortcut is displayed and should be `Alt+j Alt+r`
- It opens a Julia REPL on the bottom panel. This panel can also contain a standard terminal
- REPL has four modes :
  - Julia
  - ] : packages
  - ? : help
  - ; : shell
- Hit `Backspace` to return to Julia

### Shortcuts ([More info](https://code.visualstudio.com/docs/getstarted/keybindings))

- `Option+click` : get multiple cursors
- `Cmd+click` : follow links
- `Alt+Cmd+←/→` : navigate between tabs
- `Alt+↑/↓` : move lines up or down
- `Maj+Alt+↑/↓` : copy lines up or down

### Code completion (IntelliSense, [more info](https://code.visualstudio.com/docs/editor/intellisense))

It provides lots of (sometimes too many) suggestions. Accept suggestions with `Tab`.

Snippets are powerful completions. Extensions provide snippets but you can also create your owns ([more info](https://code.visualstudio.com/docs/editor/userdefinedsnippets)).

## Git

If you clone a repository from GitHub/GitLab, it becomes a local git repository. If not, look at [how to initialize a repository in a local folder](https://code.visualstudio.com/docs/sourcecontrol/intro-to-git#_initialize-a-repository-in-a-local-folder).

### Standard workflow (in VS Code)

1. Modify your files. Each modified file appears in the Source Control panel.
2. Go to the Source Control panel.
    1. Stage the changes you want to commit (`+` button on the right of the file name).
    2. Type a message in the upper text box which explains your changes. Select the `Commit` button.
    3. Select the `Sync Changes` button to update your local repository with the remote one.

### Tips

- Make small commits:
  - Make one change at a time
  - Commit often
  - Don't mix unrelated changes
- Write good commit messages:
  - Use simple language
  - Keep the first line short
  - Add more details in the body if needed
  - Use present tense (e.g., "Add feature" not "Added feature")
- Create a `.gitignore` file in the root directory of your repository ([more info](https://github.com/github/gitignore)).
