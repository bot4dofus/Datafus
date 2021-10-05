package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Fade extends ActionBase
   {
       
      
      private var _diffAlpha:Number;
      
      private var _endAlpha:Number;
      
      public function Fade(startAlpha:Number = 1, endAlpha:Number = 0)
      {
         super();
         this._diffAlpha = startAlpha - endAlpha;
         this._endAlpha = endAlpha;
      }
      
      public function get startAlpha() : Number
      {
         return this._endAlpha + this._diffAlpha;
      }
      
      public function set startAlpha(value:Number) : void
      {
         this._diffAlpha = value - this._endAlpha;
      }
      
      public function get endAlpha() : Number
      {
         return this._endAlpha;
      }
      
      public function set endAlpha(value:Number) : void
      {
         this._diffAlpha = this._endAlpha + this._diffAlpha - value;
         this._endAlpha = value;
      }
      
      override public function getDefaultPriority() : Number
      {
         return -5;
      }
      
      override public function update(emitter:Emitter, particle:Particle, time:Number) : void
      {
         var alpha:Number = this._endAlpha + this._diffAlpha * particle.energy;
         particle.color = particle.color & 16777215 | Math.round(alpha * 255) << 24;
      }
   }
}
