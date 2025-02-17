## Remarks

Just run it with no argument:

    ruby entry.rb

I confirmed the following implementations/platforms:

*  ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin23]

## Description

"Make a wish three times"

If you can make a wish three times before the shooting star disappears, your wish will come true.

This Ruby program simulates a shooting star animation in the terminal.
The star moves down the screen while leaving a trail of random characters (' ', '.', '*', '✨'). 
Once the animation reaches the bottom, a final static display appears, followed by a line of mountain ('⛰️ ') symbols.

### Internals

- Initialization
  - The program defines a lambda function and immediately calls it with (50, 20, 0.1).
- Animation Loop
  - Clears the screen.
  - Prints a gradually growing star trail using randomly chosen symbols.
  - Moves the 🌟 downward in each iteration.
  - Sleeps for a short duration to create animation effect.
- Final Static Display
  - Clears the screen.
  - Prints a full screen of trailing characters.
  - Prints a row of ⛰️ at the bottom to end the animation.