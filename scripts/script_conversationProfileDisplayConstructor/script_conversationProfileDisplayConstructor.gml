// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createProfileDisplay(_type, _x, _y, _imageAngle, _active, _profileData) : createRoomObject(_type, _x, _y, _imageAngle, _active) constructor {
	profileData = _profileData; // profiledata struct
	isBlank = false; // keep track of whether to display as blank task or show current data
	
	static checkIsBlank = function() {
		isBlank = profileData.checkIsBlank();
	}
	
	static getIsBlank = function() {
		return isBlank;	
	}
	
	static setIsBlank = function(state) {
		isBlank = state;
	}
	
	static updateProfileData = function(newProfileData) {
		profileData = newProfileData;
		checkIsBlank();
	}
	
	static getProfileData = function() {
		return profileData;
	}
	
	static getName = function() {
		return profileData.getName();
	}
	
	static getFileName = function() {
		return  profileData.getFileName();
	}
	
	static getPosition = function() { // NOT SOME INDEX SHIT, ONLY JOB POSITION
		return  profileData.getPosition();
	}
	
	static getDivision = function() {
		return  profileData.getDivision();
	}
	
	static getSecurityClearance = function() {
		return  profileData.getSecurityClearance();
	}
	
	static getEmploymentDate = function() {
		return  profileData.getEmploymentDate();
	}
	
	static getDateOfBirth = function() {
		return  profileData.getDateOfBirth();
	}
	
	static getPersonalTerminalID = function() {
		return profileData.getPersonalTerminalID();
	}
	
	static getPreviousConversations = function() {
		return profileData.getPreviousConversations();
	}
	
	static getCurrentConversationFileName = function() {
		return profileData.getCurrentConversationFileName();
	}
	
	static getHasCurrentConversation = function() {
		return profileData.getHasCurrentConversation();
	}
}

function createProfileButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _profileData) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	profileData = _profileData;
}

function createConversationHistoryButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _previousConversations) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	previousConversations = _previousConversations;
}

function createConversationLoaderButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID, _currentConversationFileName) : createButton(_inputX, _inputY, _width, _height, _text, _dataHandler, _templateFile, _buttonID) constructor {
	currentConversationFileName = _currentConversationFileName;
}