package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.utils.interpolateColors;
   
   public class ColorInit extends InitializerBase
   {
       
      
      private var _min:uint;
      
      private var _max:uint;
      
      public function ColorInit(color1:uint, color2:uint)
      {
         super();
         this._min = color1;
         this._max = color2;
      }
      
      public function get minColor() : uint
      {
         return this._min;
      }
      
      public function set minColor(value:uint) : void
      {
         this._min = value;
      }
      
      public function get maxColor() : uint
      {
         return this._max;
      }
      
      public function set maxColor(value:uint) : void
      {
         this._max = value;
      }
      
      public function get color() : uint
      {
         return this._min == this._max ? uint(this._min) : uint(interpolateColors(this._max,this._min,0.5));
      }
      
      public function set color(value:uint) : void
      {
         this._max = this._min = value;
      }
      
      override public function initialize(emitter:Emitter, particle:Particle) : void
      {
         if(this._max == this._min)
         {
            particle.color = this._min;
         }
         else
         {
            particle.color = interpolateColors(this._min,this._max,Math.random());
         }
      }
   }
}
