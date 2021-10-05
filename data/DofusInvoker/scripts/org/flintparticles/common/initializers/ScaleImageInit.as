package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ScaleImageInit extends InitializerBase
   {
       
      
      private var _min:Number;
      
      private var _max:Number;
      
      public function ScaleImageInit(minScale:Number, maxScale:Number = NaN)
      {
         super();
         this._min = minScale;
         if(isNaN(maxScale))
         {
            this._max = this._min;
         }
         else
         {
            this._max = maxScale;
         }
      }
      
      public function get minScale() : Number
      {
         return this._min;
      }
      
      public function set minScale(value:Number) : void
      {
         this._min = value;
      }
      
      public function get maxScale() : Number
      {
         return this._max;
      }
      
      public function set maxScale(value:Number) : void
      {
         this._max = value;
      }
      
      public function get scale() : Number
      {
         return this._min == this._max ? Number(this._min) : Number((this._max + this._min) / 2);
      }
      
      public function set scale(value:Number) : void
      {
         this._max = this._min = value;
      }
      
      override public function initialize(emitter:Emitter, particle:Particle) : void
      {
         if(this._max == this._min)
         {
            particle.scale = this._min;
         }
         else
         {
            particle.scale = this._min + Math.random() * (this._max - this._min);
         }
      }
   }
}
