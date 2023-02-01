package com.ankamagames.berilia.types.uiDefinition
{
   import flash.utils.Dictionary;
   
   public class GridElement extends ContainerElement
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      public function GridElement()
      {
         super();
         MEMORY_LOG[this] = 1;
      }
   }
}
