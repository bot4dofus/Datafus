package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SocialCharacterWrapper implements IDataCenter
   {
       
      
      public var name:String;
      
      public var tag:String;
      
      public var accountId:int;
      
      public var state:int;
      
      public var lastConnection:uint = 0;
      
      public var online:Boolean = false;
      
      public var e_category:uint = 0;
      
      public var playerId:Number;
      
      public var playerName:String = "";
      
      public var breed:uint = 0;
      
      public var sex:uint = 2;
      
      public var level:int = 0;
      
      public var alignmentSide:int = 0;
      
      public var guildName:String = "";
      
      public var achievementPoints:int = 0;
      
      public function SocialCharacterWrapper(name:String, tag:String, accountId:uint)
      {
         super();
         this.name = name;
         this.tag = tag;
         this.accountId = accountId;
      }
   }
}
