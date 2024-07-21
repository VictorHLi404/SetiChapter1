/// @description Insert description here
// You can write your code in this editor


if (isDisplayActive) {
	obj_SwapProfileList.updateTotalNumberOfPages(global.conversationProfileHandler.getProfileStackLength());
	var startIndex = obj_SwapProfileList.getStartIndex();
	var displayProfileList = global.conversationProfileHandler.getDisplayProfileData(startIndex);
	for (var i = 0; i < global.conversationProfileHandler.getProfileIconViewCount(); i++) { // search through profileicon objects and update their display
		var tempProfileIcon = variable_instance_get(instance_find(obj_profileIcon,i),"profileIcon");
		tempProfileIcon.updateProfileData(displayProfileList[i]);
	}
}






















