package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   
   public interface Initializer
   {
       
      
      function getDefaultPriority() : Number;
      
      function addedToEmitter(param1:Emitter) : void;
      
      function removedFromEmitter(param1:Emitter) : void;
      
      function initialize(param1:Emitter, param2:Particle) : void;
   }
}
