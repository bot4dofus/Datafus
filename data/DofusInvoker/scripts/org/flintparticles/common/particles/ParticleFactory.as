package org.flintparticles.common.particles
{
   public interface ParticleFactory
   {
       
      
      function createParticle() : Particle;
      
      function disposeParticle(param1:Particle) : void;
   }
}
