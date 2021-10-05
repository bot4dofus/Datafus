package org.flintparticles.twoD.renderers
{
   import flash.geom.Rectangle;
   import org.flintparticles.twoD.particles.Particle2D;
   
   public class PixelRenderer extends BitmapRenderer
   {
       
      
      public function PixelRenderer(canvas:Rectangle)
      {
         super(canvas);
      }
      
      override protected function drawParticle(particle:Particle2D) : void
      {
         _bitmapData.setPixel32(Math.round(particle.x - _canvas.x),Math.round(particle.y - _canvas.y),particle.color);
      }
   }
}
