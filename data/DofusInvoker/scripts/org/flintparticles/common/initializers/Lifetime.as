package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class Lifetime extends InitializerBase
   {
       
      
      private var _max:Number;
      
      private var _min:Number;
      
      public function Lifetime(minLifetime:Number, maxLifetime:Number = NaN)
      {
         super();
         this._max = maxLifetime;
         this._min = minLifetime;
      }
      
      public function get minLifetime() : Number
      {
         return this._min;
      }
      
      public function set minLifetime(value:Number) : void
      {
         this._min = value;
      }
      
      public function get maxLifetime() : Number
      {
         return this._max;
      }
      
      public function set maxLifetime(value:Number) : void
      {
         this._max = value;
      }
      
      public function get lifetime() : Number
      {
         return this._min == this._max ? Number(this._min) : Number((this._max + this._min) * 0.5);
      }
      
      public function set lifetime(value:Number) : void
      {
         this._max = this._min = value;
      }
      
      override public function initialize(emitter:Emitter, particle:Particle) : void
      {
         if(isNaN(this._max))
         {
            particle.lifetime = this._min;
         }
         else
         {
            particle.lifetime = this._min + Math.random() * (this._max - this._min);
         }
      }
   }
}
