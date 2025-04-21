# It Follows 2 - Love2D Project

https://github.com/user-attachments/assets/82b0088b-779b-4d53-9b8b-8f2ad5ad6ab1

![Love2D](https://img.shields.io/badge/Love2D-11.3-blue)
![Lua](https://img.shields.io/badge/Lua-5.1-blue)
![Luacheck](https://img.shields.io/badge/Luacheck-0.25.0-green)

This is a Love2D project setup for the game "It Follows 2", a spiritual successor to the famous [It Follows](https://github.com/code-weekend/it-follows).

## Requirements

- [Love2D](https://love2d.org/)
- [Luacheck](https://github.com/mpeterv/luacheck) for linting

## Setup

1. Install Love2D and Luacheck using Homebrew:
   ```
   brew install love luacheck

   # or 
   make install
   ```

2. Run the game:
   ```
   make run
   ```

3. Lint the code:
   ```
   make lint
   ```

## Deployment

This project is set up to be deployed to GitHub Pages. On every push to the `main` branch, the project will be built and deployed automatically.

## Project Structure

- `main.lua`: Entry point for the Love2D application.
- `.luacheckrc`: Configuration for Luacheck.

## Best Practices

- Follow Lua best practices for code style and structure.
- Use Luacheck to maintain code quality.

