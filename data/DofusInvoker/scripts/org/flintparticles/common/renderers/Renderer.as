package org.flintparticles.common.renderers
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Renderer
   {
       
      
      function addEmitter(param1:Emitter) : void;
      
      function removeEmitter(param1:Emitter) : void;
      
      function get emitters() : Array;
   }
}
