/// @description Insert description here
// You can write your code in this editor
networkNode = noone;
uniqueNetworkNodeID = "";
alarm[0] = 2;

function isActive() {
	if (networkNode.getIsActive()) {
		return true;
	}
	else {
		return false;
	}
}

function setIsActive(state) {
	networkNode.setIsActive(state);
}

function evaluateIsActive() {
	if (!isActive()) {
		if (global.loadManagerHandler.isNodeActivationValid(networkNode) == true) {
			show_message("CHANGE SPRITE");
			sprite_index = spr_blankTile;
			setIsActive(true);
		}
	}
}


















