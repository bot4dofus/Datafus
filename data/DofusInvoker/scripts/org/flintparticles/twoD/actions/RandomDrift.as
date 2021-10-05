package org.flintparticles.twoD.actions
{
   import org.flintparticles.common.actions.ActionBase;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class RandomDrift extends ActionBase
   {
       
      
      private var _sizeX:Number;
      
      private var _sizeY:Number;
      
      public function RandomDrift(sizeX:Number, sizeY:Number)
      {
         super();
         this._sizeX = sizeX * 2;
         this._sizeY = sizeY * 2;
      }
      
      public function get driftX() : Number
      {
         return this._sizeX / 2;
      }
      
      public function set driftX(value:Number) : void
      {
         this._sizeX = value * 2;
      }
      
      public function get driftY() : Number
      {
         return this._sizeY / 2;
      }
      
      public function set driftY(value:Number) : void
      {
         this._sizeY = value * 2;
      }
      
      override public function update(emitter:Emitter, particle:Particle, time:Number) : void
      {
         var p:Particle2D = Particle2D(particle);
         p.velX += (Math.random() - 0.5) * this._sizeX * time;
         p.velY += (Math.random() - 0.5) * this._sizeY * time;
      }
   }
}
