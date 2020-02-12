//  In: marker
// Out: position

// Center point
private _center  = getMarkerPos _this;
private _centerX = _center select 0;
private _centerY = _center select 1;

// Size
private _size  = getMarkerSize _this;
_size = _size select 0;

// Direction and make sure it's between 0 and 360.
private _dir    = (markerDir _this) * -1;
_dir    = _dir % 360;
private _dirCos = cos _dir;
private _dirSin = sin _dir;

private ["_posX","_posY"];
// Select random X and Y
private _rndX = (random (_size * 2)) - _size;
private _rndY = (random (_size * 2)) - _size;

// If area is angled, shift X and Y
if (_dir != 0) then {
  _posX = _centerX + (_dirCos * _rndX - _dirSin * _rndY);
  _posY = _centerY + (_dirSin * _rndX + _dirCos * _rndY);
} else {
  _posX = _centerX + _rndX;
  _posY = _centerY + _rndY;
};

[_posX,_posY,0]