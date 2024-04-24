package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class BoundScriptUsageData implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(BoundScriptUsageData));
       
      
      public var id:int;
      
      public var scriptId:int;
      
      public var spellLevels:Vector.<uint>;
      
      public var criterion:String;
      
      public var casterMask:String;
      
      public var targetMask:String;
      
      public var targetZone:String;
      
      public var activationMask:String;
      
      public var activationZone:String;
      
      public var random:int;
      
      public var randomGroup:int;
      
      public function BoundScriptUsageData()
      {
         super();
      }
      
      public function toString() : String
      {
         return "BoundScriptUsageData id: " + this.id + ", scriptId: " + this.scriptId;
      }
   }
}
