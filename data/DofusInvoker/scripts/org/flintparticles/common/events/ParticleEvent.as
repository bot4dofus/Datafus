package org.flintparticles.common.events
{
   import flash.events.Event;
   import org.flintparticles.common.particles.Particle;
   
   public class ParticleEvent extends Event
   {
      
      public static var PARTICLE_CREATED:String = "particleCreated";
      
      public static var PARTICLE_DEAD:String = "particleDead";
      
      public static var PARTICLE_ADDED:String = "particleAdded";
       
      
      public var particle:Particle;
      
      public function ParticleEvent(type:String, particle:Particle = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
         this.particle = particle;
      }
   }
}
