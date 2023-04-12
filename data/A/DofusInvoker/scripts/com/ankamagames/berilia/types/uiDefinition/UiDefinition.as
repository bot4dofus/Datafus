package com.ankamagames.berilia.types.uiDefinition
{
   import flash.utils.Dictionary;
   
   public class UiDefinition
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      public var name:String;
      
      public var debug:Boolean = false;
      
      public var graphicTree:Array;
      
      public var kernelEvents:Array;
      
      public var constants:Array;
      
      public var className:String;
      
      public var useCache:Boolean = true;
      
      public var usePropertiesCache:Boolean = true;
      
      public var modal:Boolean = false;
      
      public var giveFocus:Boolean = true;
      
      public var transmitFocus:Boolean = true;
      
      public var scalable:Boolean = true;
      
      public var labelDebug:Boolean = false;
      
      public var fullscreen:Boolean = false;
      
      public var setOnTopOnClick:Boolean = true;
      
      public function UiDefinition()
      {
         super();
         this.graphicTree = new Array();
         this.kernelEvents = new Array();
         this.constants = new Array();
         MEMORY_LOG[this] = 1;
      }
   }
}
