package com.ankamagames.jerakine.utils.misc.classInfo
{
   import flash.utils.Dictionary;
   
   public class MetadataInfo
   {
       
      
      public var name:String;
      
      public var args:Dictionary;
      
      public function MetadataInfo(name:String, args:Dictionary)
      {
         super();
         this.name = name;
         this.args = args;
      }
   }
}
