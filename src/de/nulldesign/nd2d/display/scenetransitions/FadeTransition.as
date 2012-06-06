package de.nulldesign.nd2d.display.scenetransitions 
{
	/**
	 * ...
	 * @author Robin Wassén-Andersson
	 */
	public class FadeTransition extends ASceneTransition
	{		
		private var alphaReducePerSecond:Number;
		
		public function FadeTransition(duration:Number) {
			alphaReducePerSecond = 1 / duration;
			super();
		}
		
		override protected function step(elapsed:Number):void 
		{				
			if (this.alpha > 0)
				alpha -= alphaReducePerSecond * elapsed;
			else 
				isDone = true;
				
			super.step(elapsed);
		}
	}

}