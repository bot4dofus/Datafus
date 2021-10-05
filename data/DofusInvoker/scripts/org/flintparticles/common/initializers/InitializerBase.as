package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public class InitializerBase implements Initializer
   {
       
      
      public function InitializerBase()
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
      
      public function initialize(emitter:Emitter, particle:Particle) : void
      {
      }
   }
}
