/****************************************************************
File: UPSMON_GetPos2D.sqf
Author: MONSADA

Description:
	Funci�n que devuelve una posici�n en 2D a partir de otra, una direcci�n y una distanceX
Parameter(s):
	<--- Position
	<--- Direction
	<--- Distance
Returns:
	Position
****************************************************************/
params ["_pos","_dir","_dist"];

if (isnil "_pos") exitWith {}; 
private _targetX = _pos select 0;
private _targetY = _pos select 1; 

//Calculamos posici�n 	
private _cosU = [_dir] call UPSMON_GetCOS;
private _sinU = [_dir] call UPSMON_GetSIN;
private _cosT = abs cos(_dir);
private _sinT = abs sin(_dir);
private _relTX = _sinT * _dist * _cosU;
private _relTY = _cosT * _dist * _sinU;
private _newPosX = _targetX + _relTX;
private _newPosY = _targetY + _relTY;
private _newPos = [_newPosX,_newPosY];
_newPos;