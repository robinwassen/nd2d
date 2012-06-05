package de.nulldesign.nd2d.display
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	
	/**
	 * ...
	 * @author Björn Acker | www.bjoernacker.de
	 */
	public class ParallaxLayer extends Node2D
	{
		
		protected var _px:Number = 0;
		protected var _py:Number = 0;
		protected var _pz:Number = 0;
		internal var _scale:Number = 0;
		
		public function ParallaxLayer(z:Number = 0)
		{
			_pz = z;
		}
		
		// *****************************************************************************************************************
		// * Public																										   *
		// *****************************************************************************************************************
		public function get px():Number
		{
			return _px;
		}
		
		public function set px(value:Number):void
		{
			_px = value;
		}
		
		public function get py():Number
		{
			return _py;
		}
		
		public function set py(value:Number):void
		{
			_py = value;
		}
		
		public function get pz():Number
		{
			return _pz;
		}
		
		public function set pz(value:Number):void
		{
			_pz = value;
		}
		
		public function get scale():Number 
		{
			return _scale;
		}
	
		// *****************************************************************************************************************
		// * Protected																									   *
		// *****************************************************************************************************************
	
		// *****************************************************************************************************************
		// * Private																									   *
		// *****************************************************************************************************************
	
		// *****************************************************************************************************************
		// * Event																										   *
		// *****************************************************************************************************************
	
	}

}