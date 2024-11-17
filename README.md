# Recepia Gourmet

## The game
This is a game entry for the game jam "BOSSJam 2024". THe game was made in its entirety within 48 hours during the 15th to 17th of November 2024.

You play as the chef of a tavern in the middle of monster land, your tavern often receives weary travelers, desperate for food.
Because of a delivery delay your tavern doesn't have the stock for serving your customers, and as such, you must go out into the wild to search for food to cook. Either by gathering scraps or by slaying monsters stalking nearby.

### Controls
Arrow keys to move
left mouse to hit enemies in the direction of the mouse

## Development

### Engine
Godot engine version 4.3 (Gdscript version) for windows was used to develop this project: https://godotengine.org/download/windows/

### Assets
To ensure that no assets are released by us, they are not included in the git repo. However, as of time of writing, anyone may download the used assets for free from [Kenney Game Assets](https://kenney.nl/).

Specifically these were used:
* [Tiny town](https://kenney.nl/assets/tiny-town) (Placed in: "Assets/Tiny Town")
* [Tiny Dungeon](https://kenney.nl/assets/tiny-dungeon) (Placed in: "Assets/Tiny Dungeon")
* [Pixel Platformer Food expansion](https://kenney.nl/assets/pixel-platformer-food-expansion) (Placed in: "Assets/Pixel Platformer Food Expansion")
* [UI pack - Pixel Adventure](https://kenney.nl/assets/ui-pack-pixel-adventure) (Placed in: "Assets/ui-pack-pixel-adventure")
* [Roguelike/RPG pack](https://kenney.nl/assets/roguelike-rpg-pack) (Placed in: "Assets/Roguelike RPG Pack")

### Feature wishlist
Of course, a developer does not get to implement everything that he whishes during a jam.
If more time was allotted, these features would have been in focus:
* Animate sprites (Walking animations, hit animations)
* An actual enemy behaviour (attempt to hit player instead of only colliding)
* Ranged enemy type
* Only rewarding player coins if a whole table is served
* Make it possible to either scrap or recycle created dishes
* Add actual "guests" to the tavern

### Known bugs
* Enemies bouncing in a funny way on certain collisions with the player object
* It is impossible to pickup new dishes if the player is unable to serve a dish without reloading the tavern

## Special thanks
The author (Tim) would like to direct some special thanks:
* **Simon "Sly" Saberian**, huge support sessions with knowledgable inputs on the godot engine, I would not have been able to finish the game without your input.

* **Emil "Manjana" Högstedt**, The partnership that never was, even though you had to cancel early on in the jam, you were a great support to get the development rolling and to realise the initial concept.