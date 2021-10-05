package org.flintparticles.twoD.renderers
{
   import flash.display.DisplayObject;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.renderers.SpriteRendererBase;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class DisplayObjectRenderer extends SpriteRendererBase
   {
       
      
      public function DisplayObjectRenderer()
      {
         super();
      }
      
      override protected function renderParticles(particles:Array) : void
      {
         var particle:Particle2D = null;
         var img:DisplayObject = null;
         var len:int = particles.length;
         for(var i:int = 0; i < len; i++)
         {
            particle = particles[i];
            img = particle.image;
            img.transform.colorTransform = particle.colorTransform;
            img.transform.matrix = particle.matrixTransform;
         }
      }
      
      override protected function addParticle(particle:Particle) : void
      {
         addChildAt(particle.image,0);
      }
      
      override protected function removeParticle(particle:Particle) : void
      {
         if(contains(particle.image))
         {
            removeChild(particle.image);
         }
      }
   }
}
