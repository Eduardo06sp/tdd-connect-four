# Connect Four

This project was designed with RSpec testing prior to implementing functionality. Method stubs and mocks were used to isolate functionality in methods. Constant refactoring was necessary due to the nature of test-driven development.

## How To Play

[Here is a simple guide from wikiHow](https://www.wikihow.com/Play-Connect-4) explaining the game of Connect Four. In essence, two players alternate dropping gamepieces into columns. Whoever gets four across, vertically or diagonally first, wins.

In this project, run the main file with the command: `ruby lib/main.rb`.
You will be prompted to enter names for each player, you may simply press enter with no value to use generic names.
Then you will be asked to choose a gamepiece. Gamepieces are represented by stars.

This game is designed to be played by two humans.
You can type in numbers 1-7 to "drop" your gamepiece in a given column. Repeat until game is over.

## Reflection

In this particular project, I learned to:

* Design a project with a **test-driven development** approach
* Learn how to perform **unit testing** with RSpec
* Use **method stubs** to help simplify testing
* Use **mocks** to return specific values from methods
* Write descriptive tests to understand errors more easily
* Use **doubles** to help isolate tests
* Utilize the **Arrange, Act & Assert** testing pattern
