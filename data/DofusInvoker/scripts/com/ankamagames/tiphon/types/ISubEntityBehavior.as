package com.ankamagames.tiphon.types
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   
   public interface ISubEntityBehavior
   {
       
      
      function updateFromParentEntity(param1:TiphonSprite, param2:BehaviorData) : void;
      
      function remove() : void;
   }
}
