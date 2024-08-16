/// @description Insert description here
// You can write your code in this editor

networkNode = global.loadManagerHandler.getNodeFromID(uniqueNetworkNodeID);
networkNode.updateXY(x, y);
for (var i = 0; i < networkNode.getGridHeight(); i++) {
	for (var j = 0; j < networkNode.getGridWidth(); j++) {
		var gridCell = networkNode.getGridCell(i, j);
		if (!gridCell.isBlank()) {
			var positionalData = networkNode.getGridCoordinates(j, i);
			gridCell.updateNodeType(networkNode.getNodeName(), string(i), string (j));
			var newCell = instance_create_layer(positionalData[0], positionalData[1], "Instances", obj_processingCell);
			with (newCell) {
				cellData = gridCell;
				updateCellSprite();
			}
		}
	}
}
if (!isActive()) {
	// CODE OUT AT THE END
	sprite_index = spr_endzone;
}























