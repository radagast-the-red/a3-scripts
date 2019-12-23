// AmbientCombat 1.1 by Duke
// updated 12/22/2019: Added cleanup

// establish parameters
params["_target", "_casFrequency", "_spawnFrequency", "_spawnDistance", "_deleteDistance", "_destinations"];
ambientCombat = true;
// get enemy types
_enemy1 = (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad");
_enemy2 = (configfile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam");
_enemyTypesList = [_enemy1, _enemy2];

// create ambient groups list
_deployedGroups = [];

// main loop, is activated every 1 seconds [testing timer]
_timer = 0;
_timerStrike = 0;
while {ambientCombat} do {
	
	// order a CAS strike, if it's time
	if ( _timerStrike > _casFrequency ) then {
		_timerStrike = 0;
		
		// find a location
		_casLocation = selectRandom _destinations;
		
		// select a vehicle
		_vehicleCAS = "O_Plane_CAS_02_F";
		
		// call in the strike
		_heep = [getMarkerPos _casLocation, random 360, _vehicleCAS, 2] execVM "MIL_CAS.sqf";
	
	};
	
	// check that all groups are still in range, if not then delete
	{ 
	
		_skip = false;
		if (count units _x == 0) then {
		
			_deployedGroups deleteAt _forEachIndex;
			_skip = true;
		
		};
	
		if (!_skip) then {
			_distance = _target distance (leader _x);
			if (_distance > _deleteDistance ) then {
				{ deleteVehicle _x } forEach units _x;
				_deployedGroups deleteAt _forEachIndex;
			};
		};
	
	} forEach _deployedGroups;
	
	// spawn a group, if the time is right
	if ( _timer > _spawnFrequency ) then {
	
		_timer = 0;
		
		// randomize a spawning position
		_spawnPos = _target getRelPos [_spawnDistance, random 360];
		
		// spawn the group
		_spz = [_spawnPos, east, selectRandom _enemyTypesList] call BIS_fnc_spawnGroup;
		_deployedGroups pushBack _spz;
		
		// give orders
		_randomDestination = selectRandom _destinations;
		_wp = _spz addWaypoint [getMarkerPos _randomDestination, -1];
		
		
	};
	
	// add time
	_timer = _timer + 1;
	_timerStrike = _timerStrike + 1;
	// sleep
	sleep 1;

};

// clean up after AC is disabled
{
	{
		deleteVehicle _x;
	} forEach units _x;
} forEach _deployedGroups;
