# tw3-challenge-mode
A mod to play the game exactly how it was not meant to be played


# changes
- [craftingManager.ws](/src/game/gameplay/crafting/craftingManager.ws)
  - increased crafting costs by 2

- [levelManager.ws](/src/game/gameplay/leveling/levelManager.ws)
  - increase XP gain by 400%
  - add function to reset the progress in the current level

- [hudModuleDialog.ws](/src/game/gui/hud/modules/hudModuleDialog.ws)
  - automatic dialog picker

- [journalQuestMenu.ws](/src/game/gui/menus/journalQuestMenu.ws)
  - hide objectives and names of active quests
  - disable tracking of quests

- [hudModuleQuests.ws](/src/game/gui/hud/modules/hudModuleQuests.ws)
  - hide objectives and name of active quests

- [mapMenu.ws](src/game/gui/menus/mapMenu.ws)
  - hide objective and name of the active quest's pin

- [hud.ws](src/game/gui/hud/hud.ws)
  - randomly pick a new quest when the previous one is finished

- [r4Game.ws](src/game/r4Game.ws)
  - event on save to store the playthrough experience

- [playerWitcher.ws](src/game/player/playerWitcher.ws)
  - initialize the playthrough level

- [DeathScreenMenu.ws](src/game/gui/menus/DeathScreenMenu.ws)
  - update the playthrough experience to remove the current level progress

- [ingameMenu.ws](src/game/gui/main_menu/ingameMenu.ws)
  - update the playthrough experience when the menu is opened