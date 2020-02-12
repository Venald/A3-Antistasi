//  In: marker
// Out: array of positions
private _area    = _this;
private _corners = [];

// Center point
private _center  = getMarkerPos _area;
private _centerX = _center select 0;
private _centerY = _center select 1;

// Direction and make sure it's between 0 and 360.
private _dir    = (markerDir _area) * -1;
_dir    = _dir % 360;
private _dirCos = cos _dir;
private _dirSin = sin _dir;

// Size
private _size  = getMarkerSize _area;
private _sizeX = _size select 0;
private _sizeY = _size select 1;


private _cosX = _dirCos * _sizeX;
private _sinX = _dirSin * _sizeX;
private _cosY = _dirCos * _sizeY;
private _sinY = _dirSin * _sizeY;

private _addX = _cosX + _sinY;
private _addY = _sinX + _cosY;
private _subX = _cosX - _sinY;
private _subY = _sinX - _cosY;

// Bottom Left
private _posX = _centerX - _subX;
private _posY = _centerY - _addY;
_corners set [0,[_posX,_posY]];

// Top Left
_posX = _centerX - _addX;
_posY = _centerY - _subY;
_corners set [1,[_posX,_posY]];

// Top Right
_posX = _centerX + _subX;
_posY = _centerY + _addY;
_corners set [2,[_posX,_posY]];

// Bottom Right
_posX = _centerX + _addX;
_posY = _centerY + _subY;
_corners set [3,[_posX,_posY]];

_corners