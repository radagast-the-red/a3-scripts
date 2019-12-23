// generates a firefight which can create a convincing soundscape
// get the marker's position
_pos = getMarkerPos "firefightLocation";

// spawn LDF
_ldf = [_pos, resistance, (configfile >> "CfgGroups" >> "Indep" >> "IND_E_F" >> "Infantry" >> "I_E_InfSquad")] call BIS_fnc_spawnGroup;
_ldfArray = units _ldf;

// spawn Spetsnaz
_spz = [_pos, east, (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_reconSquad")] call BIS_fnc_spawnGroup;
_spzArray = units _spz;

// make the units beefy as hell, longer firefight
{{ 

	_x addEventHandler ["HandleDamage", {
	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;

	if (_selection == "?") exitWith {};

	_curDamage = damage _unit;
	if (_selection != "") then {_curDamage = _unit getHit _selection};
	_newDamage = _damage - _curDamage;

	_damage - _newDamage * 0.95;

	}];

 } forEach _x; } forEach [_ldfArray, _spzArray];

// wait for them to fight
sleep 110;

// delete them
{ deleteVehicle _x } forEach _ldfArray;
{ deleteVehicle _x } forEach _spzArray;
