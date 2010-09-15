﻿package away3d.tools{		import away3d.core.base.Mesh;	import away3d.core.base.Vertex;	import away3d.core.base.Object3D;	import away3d.containers.ObjectContainer3D;	import away3d.arcane;		use namespace arcane;		/**	 * Class Grid snaps vertexes/objects according to a given grid unit.<code>Grid</code>	 */	public class Grid{				private var _unit:Number;		private var _objectSpace:Boolean;				private function parse(object3d:Object3D, dovert:Boolean = true):void		{			 			if(object3d is ObjectContainer3D){							var obj:ObjectContainer3D = (object3d as ObjectContainer3D);				if(!_objectSpace){					obj.scenePosition.x -= obj.scenePosition.x%_unit;					obj.scenePosition.y -= obj.scenePosition.y%_unit;					obj.scenePosition.z -= obj.scenePosition.z%_unit;				}				for(var i:uint =0;i<obj.children.length;++i){										if(obj.children[i] is ObjectContainer3D){						parse(obj.children[i], dovert);					} else if(obj.children[i] is Mesh){												if(!_objectSpace){							obj.children[i].scenePosition.x -= obj.children[i].scenePosition.x%_unit;							obj.children[i].scenePosition.y -= obj.children[i].scenePosition.y%_unit;							obj.children[i].scenePosition.z -= obj.children[i].scenePosition.z%_unit;						}												if(dovert)							snap( (obj.children[i] as Mesh).vertices);					}				}							}else if(object3d is Mesh){				if(!_objectSpace){					obj.children[i].scenePosition.x -= obj.children[i].scenePosition.x%_unit;					obj.children[i].scenePosition.y -= obj.children[i].scenePosition.y%_unit;					obj.children[i].scenePosition.z -= obj.children[i].scenePosition.z%_unit;				}								if(dovert)					snap( (object3d as Mesh).vertices);			}			 		}		 		private function snap(vArr:Vector.<Vertex>):void		{			var v:Vertex;			for (var i:uint = 0; i < vArr.length; ++i){				v = vArr[i];				v.x -= v.x%_unit;				v.y -= v.y%_unit;				v.z -= v.z%_unit;			}		}		 		/**		*  Grid snaps vertexes according to a given grid unit		* @param	 unit						[optional] Number. The grid unit. Default is 1.		* @param	 objectSpace			[optional] Boolean. Apply only to vertexes in geometry objectspace when Object3D are considered. Default is false.		*/		 		function Grid(unit:Number = 1, objectSpace:Boolean = false):void		{			_objectSpace = objectSpace;			_unit = Math.abs(unit);		}		/**		*  Apply the grid code to a given object3D. If type ObjectContainer3D, all children Mesh vertices will be affected.		* @param	 object3d		Object3D. The Object3d to snap to grid.		* @param	 dovert			[optional]. If the vertices must be handled or not. When false only object position is snapped to grid. Default is false.		*/		public function snapObject(object3d:Object3D, dovert:Boolean = false):void		{			parse(object3d, dovert);		}		/**		*  Apply the grid code to a given set of vertexes.		* @param	 vertices		Array. An array of Vertex objects		*/				public function snapVertices(vertices:Array):void		{			snap(vertices);		}				/**		* Defines if the grid unit.		*/		public function set unit(val:Number):void		{			_unit = Math.abs(val);			_unit = (_unit ==0)? .001 : _unit;		}				public function get unit():Number		{			return _unit;		}				/**		* Defines if the grid unit is applied in objectspace or worldspace. In worldspace, objects positions are affected.		*/		public function set objectSpace(b:Boolean):void		{			_objectSpace = b;		}				public function get objectSpace():Boolean		{			return _objectSpace;		}		 	}}