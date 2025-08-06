<h1>Ruby Hangman</h1>

A classic command-line game of Hangman, built in Ruby. Guess the secret word one letter at a time before the gallows is complete!

<h2>Features:</h2>

<ul>
    <li>
        <b>Random Word Selection: </b>
        The game chooses a secret word between 5 and 12 characters long from a provided dictionary file.
    </li>
    <li>
        <b>Case-Insensitive Input: </b>
        The game correctly handles both uppercase and lowercase letter guesses.
    </li>
    <li>
        <b>Save and Load Functionality: </b>
        Players can save their game progress at the beginning of any turn and resume it later. Saved games are serialized using YAML.
    </li>
    <li>
        <b>User-Friendly Interface: </b>
        The game provides clear prompts, a visual representation of the hangman's gallows, and a list of incorrect guesses.
    </li>
    <li>
        <b>Replayable: </b>
        The program allows you to start a new game or load a previous one after a round is complete.
    </li>
</ul>

<h2>How to Play:</h2>

<ol>
    <li>Make sure you have a dict.txt file in the same directory as the script, containing a list of words on separate lines.</li>
    <li>Run the game from your terminal: ruby hangman_game.rb</li>
    <li>Follow the on-screen prompts to start a new game, load a saved game, or make your guesses.</li>
    <li>To save your game, simply type save at the start of any turn when prompted for a letter.</li>
</ol>