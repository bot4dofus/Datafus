package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Counter
   {
       
      
      function startEmitter(param1:Emitter) : uint;
      
      function updateEmitter(param1:Emitter, param2:Number) : uint;
      
      function stop() : void;
      
      function resume() : void;
   }
}
