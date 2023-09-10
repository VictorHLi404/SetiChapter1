// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createConversationButton (_inputX, _inputY, _width, _height, _text, _buttonID, _dataHandler, _templateFile, _buttonPosition, _conversationHandler) : createButton(_inputX, _inputY, _width, _height, _text, _buttonID, _dataHandler, _templateFile) constructor {
	buttonPosition = _buttonPosition;
	conversationHandler = _conversationHandler;
	
	return;

}