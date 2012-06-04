package de.nulldesign.nd2d.display
{
	import de.nulldesign.nd2d.display.Camera2D;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Björn Acker | www.bjoernacker.de
	 */
	public class AdvancedCamera2D
	{
		private var _zoomFactor:Number = 1;		
		public function set ZoomFactor(factor:Number) : void {
			_zoomFactor = factor;
		}
		
		public function get ZoomFactor() : Number {
			return _zoomFactor;			
		}
		
		
		protected var _baseCamera:Camera2D;
		protected var _target:Node2D;
		protected var _bounds:Rectangle;
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		
		protected var _movementDamping:Number = 10;
		
		protected var _focalLength:Number = 300;
		
		protected var _layers:Vector.<ParallaxLayer>;
		
		protected var _oldTargetX:Number;
		protected var _oldTargetY:Number;
		
		protected var _movementZoomFactor:Number = 0;
		
		private var _oldDist:Number = 0;
		private var _ticker:int = 0;
		private var _zoomMode:int = 0;
		private var _zoomTarget:Number;
		private var _shakeOn:Boolean = false;
		private var _shakeEndTime:int;
		private var _shakeStrength:Number;
		
		public function AdvancedCamera2D(baseCamera:Camera2D)
		{
			_baseCamera = baseCamera;
			_layers = new Vector.<ParallaxLayer>();
		}
		
		// *****************************************************************************************************************
		// * Public																										   *
		// *****************************************************************************************************************
		/**
		 * The Update method has to be called every frame.
		 */
		public function update():void
		{			
			if (_baseCamera == null)
				return;			
				
			var sw:int = _baseCamera.sceneWidth >> 1;	// half width of screen
			var sh:int = _baseCamera.sceneHeight >> 1;	// half height of screen
			
			var shakeX:Number = 0;
			var shakeY:Number = 0;
			
			if (_target != null)
			{
				if (_movementDamping == 0)
				{
					_x = -_target.x;
					_y = -_target.y;
				}
				else
				{
					_x += (-_x - _target.x) / _movementDamping;
					_y += (-_y - _target.y) / _movementDamping;
				}
				
				if (_movementZoomFactor > 0)
				{
					var dx:Number = _target.x - _oldTargetX;
					var dy:Number = _target.y - _oldTargetY;
					var dist:Number = Math.sqrt(dx * dx + dy * dy);
					_baseCamera.zoom += ((_oldDist - dist) / _movementZoomFactor);
					_oldDist = dist;
				}
				
				_oldTargetX = _target.x;
				_oldTargetY = _target.y;
			}
			
			if (_shakeOn)
			{
				var t:int = getTimer();
				if (t > _shakeEndTime)
				{
					_shakeOn = false;
				}
				else
				{
					shakeX = float( -_shakeStrength, _shakeStrength);
					shakeY = float( -_shakeStrength, _shakeStrength);
				}
			}
			
			if (_bounds != null)
			{
				if (_bounds.width < _baseCamera.sceneWidth / this.ZoomFactor) {
					this.ZoomFactor = _baseCamera.sceneWidth / _bounds.width;					
				}
				
				if (_bounds.height < _baseCamera.sceneHeight / this.ZoomFactor) {					
					this.ZoomFactor = _baseCamera.sceneHeight / _bounds.height;					
				}
				
				var cameraLeft:Number 	= _x * -1 - sw / this.ZoomFactor;
				if (cameraLeft < bounds.x) {
					_x += cameraLeft;
				}
				
				var cameraRight:Number	= _x * -1 + sw / this.ZoomFactor;
				if (bounds.width < cameraRight) {
					_x -= bounds.width - cameraRight;					
				}
				
				var cameraTop:Number 	= _y * -1 - sh / this.ZoomFactor;	
				if (cameraTop < bounds.y) {
					_y += cameraTop;
				}
				
				var cameraBottom:Number	= _y * -1 + sh / this.ZoomFactor;
				if (bounds.height < cameraBottom)
				{
					_y -= bounds.height - cameraBottom;
				}
			}
			
			var n:int = _layers.length;
			while (--n > -1)
			{
				var layer:ParallaxLayer = _layers[n];
				var d:Number = _focalLength / (_focalLength + layer.pz) * this.ZoomFactor;
				layer.x = (layer.px + _x + shakeX) * d + sw;
				layer.y = (layer.py + _y + shakeY) * d + sh;
				layer._scale = layer.scaleX = layer.scaleY = d;
			}
		}
		
		public function dispose():void
		{
			_layers = null;
			_baseCamera = null;
		}
		
		public function addLayer(layer:ParallaxLayer):void
		{
			_layers.push(layer);
		}
		
		public function removeLayer(layer:ParallaxLayer):void
		{
			var index:int = _layers.indexOf(layer);
			if (index != -1)
				_layers.splice(index, 1);
		}
		
		public function get target():Node2D
		{
			return _target;
		}
		
		public function setTarget(value:Node2D, reposition:Boolean = true):void
		{
			_target = value;
			_oldTargetX = value.x;
			_oldTargetY = value.y;
			if (reposition)
			{
				_x = -value.x;
				_y = -value.y;
			}
		}
		
		/**
		 * 
		 * @param	strength Pixels
		 * @param	duration Seconds
		 */
		public function shake(strength:Number, duration:Number = 1.0):void 
		{
			_shakeStrength = strength;
			_shakeEndTime = getTimer() + duration * 1000;
			_shakeOn = true;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function set bounds(value:Rectangle):void
		{
			_bounds = value;
		}
		
		public function get movementDamping():Number
		{
			return _movementDamping;
		}
		
		public function set movementDamping(value:Number):void
		{
			_movementDamping = value;
		}
		// *****************************************************************************************************************
		// * Protected																									   *
		// *****************************************************************************************************************
		protected function float(min:Number,max:Number):Number {
			return Math.random()*(max-min)+min;
		}
	}
}

