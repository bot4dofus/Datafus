package org.flintparticles.common.activities
{
   import org.flintparticles.common.emitters.Emitter;
   
   public interface Activity
   {
       
      
      function getDefaultPriority() : Number;
      
      function addedToEmitter(param1:Emitter) : void;
      
      function removedFromEmitter(param1:Emitter) : void;
      
      function initialize(param1:Emitter) : void;
      
      function update(param1:Emitter, param2:Number) : void;
   }
}
