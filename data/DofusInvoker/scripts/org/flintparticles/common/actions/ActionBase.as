package org.flintparticles.common.actions
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class ActionBase implements Action
   {
       
      
      public function ActionBase()
      {
         super();
      }
      
      public function getDefaultPriority() : Number
      {
         return 0;
      }
      
      public function addedToEmitter(emitter:Emitter) : void
      {
      }
      
      public function removedFromEmitter(emitter:Emitter) : void
      {
      }
      
      public function update(emitter:Emitter, particle:Particle, time:Number) : void
      {
      }
   }
}
