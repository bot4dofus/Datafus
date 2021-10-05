package com.ankamagames.tiphon.types
{
   public interface ITiphonEvent
   {
       
      
      function get label() : String;
      
      function get sprite() : *;
      
      function get params() : Object;
      
      function get animationName() : String;
   }
}
