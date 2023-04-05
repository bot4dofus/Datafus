package com.ankamagames.jerakine.types
{
   import flash.system.ApplicationDomain;
   
   public class Swl
   {
       
      
      private var _frameRate:uint;
      
      private var _classesList:Array;
      
      private var _applicationDomain:ApplicationDomain;
      
      public function Swl(frameRate:uint, classesList:Array, applicationDomain:ApplicationDomain)
      {
         super();
         this._frameRate = frameRate;
         this._classesList = classesList;
         this._applicationDomain = applicationDomain;
      }
      
      public function get frameRate() : uint
      {
         return this._frameRate;
      }
      
      public function getDefinition(name:String) : Object
      {
         return this._applicationDomain.getDefinition(name);
      }
      
      public function hasDefinition(name:String) : Boolean
      {
         return this._applicationDomain.hasDefinition(name);
      }
      
      public function getDefinitions() : Array
      {
         return this._classesList;
      }
   }
}
