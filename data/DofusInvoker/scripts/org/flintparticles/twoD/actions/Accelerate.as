package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class Accelerate extends ActionBase
   {
       
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function Accelerate(accelerationX:Number, accelerationY:Number)
      {
         super();
         this._x = accelerationX;
         this._y = accelerationY;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function set x(value:Number) : void
      {
         this._x = value;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(value:Number) : void
      {
         this._y = value;
      }
      
      override public function update(emitter:Emitter, particle:Particle, time:Number) : void
      {
         var p:Particle2D = Particle2D(particle);
         p.velX += this._x * time;
         p.velY += this._y * time;
      }
   }
}
