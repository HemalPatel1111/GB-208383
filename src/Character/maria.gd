extends Spatial

var try:= true
var _transformS:Transform
var _transformH:Transform
var _transformC:Transform

var init = Transform.scaled(Vector3(1,1,1))

func _ready():
	_transformS = $Armature/sword.transform
	_transformH = $Armature/head.transform
	_transformC = $Armature/center.transform

func _process(delta):
	if try:
		$Armature/sword.transform = init
		$Armature/head.transform = init
		$Armature/center.transform = init
		
		$Armature/sword.transform *= $Armature/Skeleton.get_bone_global_pose(31)
		$Armature/sword.transform *= _transformS
		
		$Armature/head.transform *= $Armature/Skeleton.get_bone_global_pose(5)
		$Armature/head.transform *= _transformH
		
		$Armature/center.transform *= $Armature/Skeleton.get_bone_global_pose(1)
		$Armature/center.transform *= _transformC
		
