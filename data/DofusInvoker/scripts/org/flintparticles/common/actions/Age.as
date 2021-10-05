package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.energyEasing.Linear;
   import org.flintparticles.common.particles.Particle;
   
   public class Age extends ActionBase
   {
       
      
      private var _easing:Function;
      
      public function Age(easing:Function = null)
      {
         super();
         if(easing == null)
         {
            this._easing = Linear.easeNone;
         }
         else
         {
            this._easing = easing;
         }
      }
      
      public function get easing() : Function
      {
         return this._easing;
      }
      
      public function set easing(value:Function) : void
      {
         this._easing = value;
      }
      
      override public function update(emitter:Emitter, particle:Particle, time:Number) : void
      {
         particle.age += time;
         if(particle.age >= particle.lifetime)
         {
            particle.energy = 0;
            particle.isDead = true;
         }
         else
         {
            particle.energy = this._easing(particle.age,particle.lifetime);
         }
      }
   }
}
