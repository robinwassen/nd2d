package de.nulldesign.nd2d.display.scenetransitions 
{
	import de.nulldesign.nd2d.display.Camera2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.Sprite2DMaterial;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import de.nulldesign.nd2d.utils.StatsObject;
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.events.Event;
	
	/**
	 * Abstract base class for scene transitions.
	 * Transitions should inherit from this class and implement their transition behaviour in an override of the step method.
	 * 
	 * @author Robin Wassén-Andersson.
	 */
	
	public class ASceneTransition extends Sprite2D
	{		
		public var isDone:Boolean = false;
		
		private var _sceneBitmapData:BitmapData;
		
		public function ASceneTransition()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super();
		}
		
		private function onAddedToStage(e:Event) : void {
			x = stage.stageWidth / 2;		
			y = stage.stageHeight / 2;
			
			_sceneBitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			
			this.setTexture(Texture2D.textureFromBitmapData(_sceneBitmapData));
			
			if (this.material == null) {
				this.setMaterial(new Sprite2DMaterial());				
			}
		}
		
		public function set sceneBitmapData(value:BitmapData) : void {
			_sceneBitmapData = value;
		}
		
		public function get sceneBitmapData() : BitmapData {
			return _sceneBitmapData;
		}
	}
	
}