// SET OF FUNCTIONS USED TO READ COMMANDS FROM ARTICY DRAFT STUFF TO UPDATE N CHANGE NPC CONDITIONS

// within articy, ALL files are put underneath the namespace of gameState, plural S
	
// NEW FORMAT: CHECK BOTH NPC FILE AND PLAYER FILE
// npc file is underneath name of NPCState
// player file is underneath name of playerState

function isNPCStatement(expressionString) {  // returns true if associated statement is related to npc, returns false if associated statement is related to player
	if (string_contains("NPCState.", expressionString)) {
		return true;
	}
	else {
		return false;
	}
}

function isNPCData(expressionString, currentNPC, playerData) { // returns the associated struct for the expression statement being evaluated
	if (isNPCStatement(expressionString)) {
		return currentNPC;
	}
	else {
		return playerData;
	}
}

function pruneStatement(expressionString) { // returns string
	if (isNPCStatement(expressionString)) { 
		return string_replace(expressionString, "NPCState.", "");
	}
	else {
		return string_replace(expressionString, "playerState.", "");
	}
}

function containsInteger(expressionString) { // returns boolean,  used to check if if statement is 
	var integerString = string_digits(expressionString);
	return (string_length(integerString) > 0);
}

function pullIntegerFromStatement(expressionString) { // returns integer
	var dataArray = string_split(expressionString, " "); 
	var valueString = dataArray[array_length(dataArray)-1]; // parse for the actual number
	valueString = string_replace(valueString, ";", "");
	return real(valueString);
}

function pullFlagNameFromStatement(expressionString) { // returns name of the boolean to be changed/read
	var dataArray = string_split(expressionString, " ");
	var flagName = dataArray[0];
	return flagName;
}

function pullFlagBooleanFromStatement(expressionString) {
	var dataArray = string_split(expressionString, " ");
	var valueString = dataArray[array_length(dataArray)-1]; // parse for the actual number
	valueString = string_replace(valueString, ";", "");
	if (string_contains("true", valueString)) {
		return true;
	}
	else {
		return false;
	}
}

function pullStatNameFromStatement(expressionString) { // consider building in safeguard against bad variable names? returns string
	var statName = "";
	if (string_contains("agreeability", expressionString)) {
		statName = "agreeability";
	}
	else if (string_contains("trust", expressionString)) {
		statName = "trust";
	}
	else if (string_contains("fear", expressionString)) {
		statName = "fear";
	}
	return statName;
}

function pullEqualityTypeFromStatement(expressionString) { // returns string
	var equalityType = "";
	if (string_contains(">=", expressionString)) {
		equalityType = ">=";
	}
	else if (string_contains("<=", expressionString)) {
		equalityType = "<=";
	}
	else if (string_contains("==", expressionString)) {
		equalityType = "==";
	}
	return equalityType;
}
