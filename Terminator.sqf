HintSilent "A terminator has been deployed on the battlefield!";

_this setSkill["aimingShake", 1];
_this setSkill["aimingSpeed", 1];
_this setSkill["endurance", 1];
_this setSkill["spotDistance", 1];
_this setSkill["spotTime", 1];
_this setSkill["courage", 1];
_this setSkill["reloadSpeed", 1];
_this setSkill["commanding", 1];
_this setSkill["general", 1];

_this setCustomAimCoef 0;
_this setUnitRecoilCoefficient 0;

_this enableFatigue false;

_this setAnimSpeedCoef 1.2;

_this addEventHandler ["HandleDamage", {
  _unit = _this select 0;
  _selection = _this select 1;
  _damage = _this select 2;

  if (_selection == "?") exitWith {};

  _curDamage = damage _unit;
  if (_selection != "") then {_curDamage = _unit getHit _selection};
  _newDamage = _damage - _curDamage;

  _damage - _newDamage * 0.87;
}];

// this adds explosive bullets !

//_this addeventhandler ["fired", {
 // _bullet = nearestObject [_this select 0,_this select 4];
  //_bulletpos = getPosASL _bullet;
  //_o = "M_AT" createVehicle _bulletpos;
  //_weapdir = player weaponDirection currentWeapon player;
  //_dist = 1;
  //_o setPosASL [
   // (_bulletpos select 0) + (_weapdir select 0)*_dist,
    //(_bulletpos select 1) + (_weapdir select 1)*_dist,
    //(_bulletpos select 2) + (_weapdir select 2)*_dist
  //];
  //_up = vectorUp _bullet;
  //_o setVectorDirAndUp[_weapdir,_up];
  //_o setVelocity velocity _bullet;
//}];
