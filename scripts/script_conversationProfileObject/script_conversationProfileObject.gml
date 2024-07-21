// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createNPCProfile(_name, _fileName, _position, _division, _securityClearance, _employmentDate, _dateOfBirth, _personalTerminalID, _previousConversations) constructor {
	name = _name; // read only string
	fileName = _fileName; // string, path to the file used for resaving
	position = _position; // read only string
	division = _division; // read only string
	securityClearance = _securityClearance; // read only string
	employmentDate = _employmentDate; // read only string
	dateOfBirth = _dateOfBirth; // read only string
	personalTerminalID = _personalTerminalID; // read only string
	previousConversations = _previousConversations; // string that contains list of previous conversations to be loaded

	hasCurrentConversation = false; // externally updated by handler to upload if there is a conversation or not
	currentConversationFileName = "";
	
	static checkIsBlank = function() {
		if (name == "BlankProfile") {
			return true;
		}
		else {
			return false;
		}
	}
	
	static getName = function() {
		return name;
	}
	
	static getFileName = function() {
		return fileName;
	}
	
	static getPosition = function() { // NOT SOME INDEX SHIT, ONLY JOB POSITION
		return position;
	}
	
	static getDivision = function() {
		return division;
	}
	
	static getSecurityClearance = function() {
		return securityClearance;
	}
	
	static getEmploymentDate = function() {
		return employmentDate;
	}
	
	static getDateOfBirth = function() {
		return dateOfBirth;
	}
	
	static getPersonalTerminalID = function() {
		return personalTerminalID;
	}
	
	static getPreviousConversations = function() {
		return previousConversations;
	}
	
	static getCurrentConversationFileName = function() {
		return currentConversationFileName;
	}
	
	static setHasCurrentConversation = function(state) {
		hasCurrentConversation = state;
	}
	
	static getHasCurrentConversation = function() {
		return hasCurrentConversation;
	}
}