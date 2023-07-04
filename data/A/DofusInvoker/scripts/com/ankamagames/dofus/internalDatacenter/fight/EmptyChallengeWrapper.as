package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.network.enums.ChallengeStateEnum;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.types.Uri;
   
   public class EmptyChallengeWrapper extends ChallengeWrapper implements IDataCenter, ISlotData
   {
       
      
      public function EmptyChallengeWrapper()
      {
         super();
      }
      
      public static function create() : EmptyChallengeWrapper
      {
         return new EmptyChallengeWrapper();
      }
      
      override public function get id() : uint
      {
         return Number.NaN;
      }
      
      override public function get state() : uint
      {
         return ChallengeStateEnum.CHALLENGE_RUNNING;
      }
      
      override public function get iconUri() : Uri
      {
         return new Uri(XmlConfig.getInstance().getEntry("config.gfx.path.challenges").concat("10026.png"));
      }
      
      override public function get description() : String
      {
         return "";
      }
      
      override public function get name() : String
      {
         return "";
      }
      
      override public function get categoryId() : int
      {
         return EnumChallengeCategory.FIGHT;
      }
   }
}

class ChallengeTargetWrapper
{
    
   
   public var targetId:Number = 0;
   
   public var targetCell:int = 0;
   
   public var targetName:String = "";
   
   public var targetlevel:int = 1;
   
   public var attackers:Vector.<Number>;
   
   function ChallengeTargetWrapper()
   {
      this.attackers = new Vector.<Number>();
      super();
   }
}
