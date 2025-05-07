# It Follows 2 - Survive the Chase

![Love2D](https://img.shields.io/badge/Love2D-11.3-blue)
![Lua](https://img.shields.io/badge/Lua-5.1-blue)
![Luacheck](https://img.shields.io/badge/Luacheck-0.25.0-green)

## Game Overview

"It Follows 2" is an intense survival arcade game, a spiritual successor to the original [It Follows](https://github.com/code-weekend/it-follows). In this game, you control a character who must constantly stay on the move to avoid being caught by an ever-growing number of relentless pursuers.


### Gameplay

- **Endless Survival**: Test your reflexes and strategy as you evade enemies that never stop hunting you
- **Increasing Difficulty**: Face more enemies as time progresses, with faster and more challenging pursuit patterns
- **Motion-Based Mechanics**: Your character leaves a motion trail as you move, adding a visual element to the chase
- **Minimalist Design**: Clean interface focused on the core gameplay experience

### Controls

- **Keyboard**: Arrow keys or HJKL (Vim-style) for movement
- **Touch**: Drag anywhere on screen to control movement direction and speed
- **Game Flow**: Tap, click, or press Enter to start/restart the game
- **Exit**: Press Escape or Q to quit


## Requirements

- [Love2D](https://love2d.org/) (v11.3 recommended)
- [Luacheck](https://github.com/mpeterv/luacheck) for linting (optional, for development)

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


## Project Structure

The game is built with a modular architecture:

- `main.lua`: Entry point for the Love2D application
- `game.lua`: Core game loop and state management
- `player.lua`: Player entity with movement and rendering
- `enemies.lua`: Enemy spawning and behavior logic
- `score.lua`: Scoring and game statistics
- `helpers/`: Utility modules
  - `world.lua`: Coordinate system and world management
  - `render.lua`: UI rendering functions
  - `keys.lua`: Input handling

## Deployment

This project uses GitHub Actions for CI/CD. On every push to the `main` branch, the project will be built and deployed automatically to GitHub Pages.


## Development Guidelines

- Follow Lua best practices for code style and structure
- Use Luacheck to maintain code quality
- Keep modules focused on single responsibilities
- Document functions with LuaDoc style comments

## Acknowledgements

- Original "It Follows" concept by [code-weekend](https://github.com/code-weekend/it-follows)
- Built with [Love2D](https://love2d.org/), an awesome framework for making 2D games in Lua

