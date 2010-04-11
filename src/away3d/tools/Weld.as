﻿package away3d.tools{		import away3d.core.base.Mesh;	import away3d.core.base.Vertex;	import away3d.core.base.Face;	import away3d.core.base.UV;	import away3d.core.base.Geometry;	import away3d.core.base.Object3D;	import away3d.containers.ObjectContainer3D;		import away3d.materials.Material;	import away3d.arcane;		use namespace arcane;	  		/**	 * Class Weld removes from the faces found of one or more object3d all the duplicated vertexes and uv's<Weld></code>	 */	public class Weld{		private var _av:Array;		private var _auv:Array;		private var _bUv:Boolean;		private var _delv:int;		private var _delu:int;		 		private function parse(object3d:Object3D):void		{			 			if(object3d is ObjectContainer3D){							var obj:ObjectContainer3D = (object3d as ObjectContainer3D);							for(var i:int =0;i<obj.children.length;++i){										if(obj.children[i] is ObjectContainer3D){						parse(obj.children[i]);					} else if(obj.children[i] is Mesh){						weld( obj.children[i]);					}				}							} else if (object3d is Mesh){				weld( object3d as Mesh);			}			 		}				private function checkVertex(v:Vertex):Vertex		{			for(var i:int=0;i<_av.length;++i){				if(v.x == _av[i].x && v.y == _av[i].y && v.z == _av[i].z ){					if(v != _av[i]){						_delv ++;					}					return _av[i];				}			}			_av.push(v);						return v;		}				private function checkUV(uv:UV):UV		{			for(var i:int=0;i<_auv.length;++i){				if(uv.u == _auv[i].u && uv.v == _auv[i].v){					if(uv != _auv[i]){						_delu ++;					}					return _auv[i];				}			}			_auv.push(uv);						return uv;		}				private function weld(obj:Mesh):void		{			var face:Face;			var i:int = 0;			var loop:int = obj.faces.length;						var v0:Vertex;			var v1:Vertex;			var v2:Vertex;						var uv0:UV;			var uv1:UV;			var uv2:UV;						var mat:Material;						var aFaces:Array = [];						for(i=0;i<loop;++i){				face = obj.faces[i];				v0 = checkVertex(face.v0);				v1 = checkVertex(face.v1);				v2 = checkVertex(face.v2);								if(_bUv){					uv0 = checkUV(face.uv0);					uv1 = checkUV(face.uv1);					uv2 = checkUV(face.uv2);				} else{					uv0 = face.uv0;					uv1 = face.uv1;					uv2 = face.uv2;				}				mat = face.material;								aFaces.push(new Face(v0, v1, v2, mat, uv0, uv1, uv2));			}						obj.geometry = null;						obj.geometry = new Geometry();						for(i = 0;i<aFaces.length;++i){				obj.addFace(aFaces[i]);			}			_av = null;			_auv = null;			aFaces = null;				 		}		 		/**		*  Class Weld removes from the faces found of an object3d all the duplicated vertexes and uv's.		* @param	 doUVs			[optional] Boolean. If uv's needs to be optimized as well. Default is true.		*/		 		function Weld(doUVs:Boolean = true):void		{			_bUv = doUVs;		}		/**		*  Apply the welding code to a given object3D.		* @param	 object3d		Object3D. The target Object3d object.		*/		public function apply(object3d:Object3D):void		{			_delv = _delu = 0;			_av = [];						if(_bUv)				_auv = [];							parse(object3d);						_av = null;						if(_bUv)				_auv = null;		}				/**		* Defines if the weld operation treats the UV's.		*/		public function set doUVs(b:Boolean):void		{			_bUv = b;		}				public function get doUVs():Boolean		{			return _bUv;		}				/**		* returns howmany vertexes were deleted during the welding operation.		*/		public function get countvertices():int		{			return _delv;		}				/**		* returns howmany uvs were deleted during the welding operation.		*/		public function get countuvs():int		{			return _delu;		}					}}