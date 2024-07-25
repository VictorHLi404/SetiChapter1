// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function createBonusCounter() constructor { // can be added to itself
	singleTaskCompletionSpeed = 1; // HOW FAST IT TAKES TO COMPLETE A SINGLE TASK
	multiTaskcompletionSpeed = 1; // HOW MUCH IS NOT LOST WHEN TASKS ARE SPLIT INTO SEPERATE AREAS
	optimizationBulletCount = 0; // how many bullets you max out at 
	optimizationBulletRegenerationRate = 1; // how fast you gain back optimization attempts
	optimizationResourceCount = 0; // how many walls / external object you get
	signalVariance = 1; // "DIFFICULTY" SLIDER FOR THE scanning minimgame
	signalInterpolation = 1; // "tolerance" slider for scanning, determines how much the computer can autofill / what is considered correct
	dataCompression = 1; // the rate at which data objects appear, slows down / allows more to be packed into one slot
	firewallSupression = 1;
	
	StringToMultiplicativeVariableMap = {
		"SignalVariance": signalVariance,
		"SignalInterpolation" : signalInterpolation,
		"SingleTaskCompletionSpeed" : singleTaskCompletionSpeed
	}
	
	StringToAdditiveVariableMap = {
		"OptimizationBulletCount" : optimizationBulletCount,
		"OptimizationResourceCount" : optimizationResourceCount
	}
	
	static getMultiplicativeVariable = function(valueName) {
		return StringToMultiplicativeVariableMap[$ valueName];
	}
	
	static getAdditiveVariable = function(valueName) {
		return StringToAdditiveVariableMap[$ valueName];
	}
	
	static updateBonuses = function(newBonusData) {
		var multiplicativeVariableNames = struct_get_names(StringToMultiplicativeVariableMap);
		var additiveVariableNames = struct_get_names(StringToAdditiveVariableMap);
		if (array_contains(multiplicativeVariableNames, newBonusData[0])) { // multiplier data
			StringToMultiplicativeVariableMap[$ newBonusData[0]] *= newBonusData[1];
		}
		else {
			StringToAdditiveVariableMap[$ newBonusData[0]] += newBonusData[1];
		}
	}
	
	static combineBonusCounter = function(otherCounter) { // take in OTHER bonusCounter, loop and sum
		var multiplicativeVariableNames = struct_get_names(StringToMultiplicativeVariableMap);
		var additiveVariableNames = struct_get_names(StringToAdditiveVariableMap);
		for (var i = 0; i < array_length(multiplicativeVariableNames); i++) {
			var variableName = multiplicativeVariableNames[i];
			if (otherCounter.getMultiplicativeVariable(variableName) != 1 && getMultiplicativeVariable(variableName) != 1) {
				StringToMultiplicativeVariableMap[$ variableName] = power(getMultiplicativeVariable(variableName)*otherCounter.getMultiplicativeVariable(variableName), 0.75);
			}
			else {
				StringToMultiplicativeVariableMap[$ variableName] = power(getMultiplicativeVariable(variableName)*otherCounter.getMultiplicativeVariable(variableName), 1);
			}
		}
		for (var i = 0; i < array_length(additiveVariableNames); i++) {
			var variableName = additiveVariableNames[i];
			StringToAdditiveVariableMap[$ variableName] += otherCounter.getAdditiveVariable(variableName)
		}
		return;
	}
	
	
}