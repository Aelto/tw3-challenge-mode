
function MCM_initializePlaythroughLevel(master: W3PlayerWitcher) {
  var player_level: int;
  var player_experience: int;
  var level_manager : W3LevelManager;
  var current_player_experience: int;

  level_manager = master.levelManager;

  // this represents the amount of experience the player currently has:
  //  + the experience to reach the current level
  //  + the experience in the current level to progress to the next level
  current_player_experience = level_manager.GetPointsTotal(EExperiencePoint);
		
  if (master.MCM_playthrough_id == '') {
    MCMLOG("no playthrough level yet");
    master.MCM_playthrough_id = MCM_getNextPlaythroughId();
    master.MCM_playthrough_experience = current_player_experience;

    MCM_updatePlaythroughIdCounter();
  }
  else {
    master.MCM_playthrough_experience = MCM_getPlaythroughExperience(
      master.MCM_playthrough_id
    );
  }

  MCMLOG("playthrough id = " + master.MCM_playthrough_id);
  MCMLOG("playthrough xp = " + master.MCM_playthrough_experience);
  MCMLOG("current xp = " + current_player_experience);

  // the player has a higher level than what the playthrough experience says,
  // it means he probably died and its progress in the current level should
  // be reset.
  if (master.MCM_playthrough_experience < current_player_experience) {
    level_manager.resetCurrentLevelProgress();
  }
}

function MCM_getNextPlaythroughId(): name {
	var wrapper: CInGameConfigWrapper;
  var counter: int;

  wrapper = theGame.GetInGameConfigWrapper();
  counter = StringToInt(wrapper.GetVarValue('MCMplaythrough', 'playthrough_counter'));

  if (counter == 0) {
    return 'level0';
  }

  if (counter == 1) {
    return 'level1';
  }

  if (counter == 2) {
    return 'level2';
  }

  if (counter == 3) {
    return 'level3';
  }

  if (counter == 4) {
    return 'level4';
  }

  if (counter == 5) {
    return 'level5';
  }

  if (counter == 6) {
    return 'level6';
  }

  if (counter == 7) {
    return 'level7';
  }

  if (counter == 8) {
    return 'level8';
  }

  return 'level9';
}

function MCM_updatePlaythroughIdCounter() {
  var wrapper: CInGameConfigWrapper;
  var counter: int;

  wrapper = theGame.GetInGameConfigWrapper();
  counter = StringToInt(wrapper.GetVarValue('MCMplaythrough', 'playthrough_counter'));

  wrapper.SetVarValue(
    'MCMplaythrough',
    'playthrough_counter',
    IntToString(counter + 1)
  );

}

/**
 * returns the experience value from the slider. It represents the total
 * of experience needed to get to this level starting from level 0 + the current
 * experience gained in the current level.
 */
function MCM_getPlaythroughExperience(playthrough_id: name): int {
  var wrapper: CInGameConfigWrapper;

  wrapper = theGame.GetInGameConfigWrapper();

  return StringToInt(wrapper.GetVarValue('MCMplaythrough', playthrough_id));
}

function MCM_updatePlaythroughExperience(level_manager : W3LevelManager) {
  var current_player_experience: int;
  var witcher: W3PlayerWitcher;
  
  witcher = GetWitcherPlayer();

  // this represents the amount of experience the player currently has:
  //  + the experience to reach the current level
  //  + the experience in the current level to progress to the next level
  current_player_experience = level_manager.GetPointsTotal(EExperiencePoint);

  witcher.MCM_playthrough_experience = current_player_experience;
}

function MCM_deathResetAndSavePlaythroughExperience() {
  var level_manager : W3LevelManager;
  var current_level_experience: int;
  var witcher: W3PlayerWitcher;

  witcher = GetWitcherPlayer();
  level_manager = witcher.levelManager;

  current_level_experience = level_manager.GetPointsUsed(EExperiencePoint);

  witcher.MCM_playthrough_experience = current_level_experience;

  MCM_savePlaythroughExperience();
}

function MCM_savePlaythroughExperience() {
  var wrapper: CInGameConfigWrapper;
  var witcher: W3PlayerWitcher;

  witcher = GetWitcherPlayer();

  MCMLOG(
    "saving playthrough experience, id = " +
    witcher.MCM_playthrough_id + ", xp = " +
    witcher.MCM_playthrough_experience
  );

  wrapper = theGame.GetInGameConfigWrapper();

  if (witcher.MCM_playthrough_id != ''
  &&  witcher.MCM_playthrough_experience > 0) {

    wrapper.SetVarValue(
      'MCMplaythrough',
      witcher.MCM_playthrough_id,
      IntToString(witcher.MCM_playthrough_experience)
    );

    theGame.SaveUserSettings();

  }
}