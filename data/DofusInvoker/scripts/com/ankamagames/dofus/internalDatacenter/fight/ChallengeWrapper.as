package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public class ChallengeWrapper extends Proxy implements IDataCenter, ISlotData
   {
       
      
      private var _challenge:Challenge;
      
      private var _id:uint;
      
      private var _targetId:Number;
      
      private var _targetName:String;
      
      private var _targetLevel:int;
      
      private var _xpBonus:uint;
      
      private var _dropBonus:uint;
      
      private var _result:uint;
      
      public function ChallengeWrapper()
      {
         super();
      }
      
      public static function create() : ChallengeWrapper
      {
         return new ChallengeWrapper();
      }
      
      public function set id(id:uint) : void
      {
         this._challenge = Challenge.getChallengeById(id);
         this._id = id;
      }
      
      public function set targetId(targetId:Number) : void
      {
         this._targetId = targetId;
         this._targetName = this.getFightFrame().getFighterName(targetId);
         this._targetLevel = this.getFightFrame().getFighterLevel(targetId);
      }
      
      public function set xpBonus(xpBonus:uint) : void
      {
         this._xpBonus = xpBonus;
      }
      
      public function set dropBonus(dropBonus:uint) : void
      {
         this._dropBonus = dropBonus;
      }
      
      public function set result(result:uint) : void
      {
         this._result = result;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get targetId() : Number
      {
         return this._targetId;
      }
      
      public function get targetName() : String
      {
         return this._targetName;
      }
      
      public function get targetLevel() : int
      {
         return this._targetLevel;
      }
      
      public function get xpBonus() : uint
      {
         return this._xpBonus;
      }
      
      public function get dropBonus() : uint
      {
         return this._dropBonus;
      }
      
      public function get result() : uint
      {
         return this._result;
      }
      
      public function get iconUri() : Uri
      {
         if(this._challenge !== null)
         {
            return this._challenge.iconUri;
         }
         return null;
      }
      
      public function get description() : String
      {
         return this._challenge.description;
      }
      
      public function get name() : String
      {
         return this._challenge.name;
      }
      
      public function get categoryId() : int
      {
         return this._challenge.categoryId;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var l:* = undefined;
         var r:* = undefined;
         if(isAttribute(name))
         {
            return this[name];
         }
         l = Challenge.getChallengeById(this.id);
         if(!l)
         {
            r = "";
         }
         try
         {
            return l[name];
         }
         catch(e:Error)
         {
            return "Error_on_challenge_" + name;
         }
      }
      
      public function get fullSizeIconUri() : Uri
      {
         return this.iconUri;
      }
      
      public function get errorIconUri() : Uri
      {
         return null;
      }
      
      public function get backGroundIconUri() : Uri
      {
         return null;
      }
      
      public function get info1() : String
      {
         return "";
      }
      
      public function get active() : Boolean
      {
         return true;
      }
      
      public function get timer() : int
      {
         return 0;
      }
      
      public function get startTime() : int
      {
         return 0;
      }
      
      public function get endTime() : int
      {
         return 0;
      }
      
      public function set endTime(t:int) : void
      {
      }
      
      public function addHolder(h:ISlotDataHolder) : void
      {
      }
      
      public function removeHolder(h:ISlotDataHolder) : void
      {
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return isAttribute(name);
      }
      
      public function get boundAchievements() : Vector.<Achievement>
      {
         return this._challenge.boundAchievements;
      }
      
      public function getTurnsNumberForCompletion() : Number
      {
         if(this._challenge === null)
         {
            return Number.NaN;
         }
         return this._challenge.getTurnsNumberForCompletion();
      }
      
      public function getBoundBossId() : Number
      {
         if(this._challenge === null)
         {
            return Number.NaN;
         }
         return this._challenge.getBoundBossId();
      }
      
      public function getTargetMonsterId() : Number
      {
         if(this._challenge === null)
         {
            return Number.NaN;
         }
         return this._challenge.getTargetMonsterId();
      }
      
      public function getPlayersNumberType() : Number
      {
         if(this._challenge === null)
         {
            return Number.NaN;
         }
         return this._challenge.getPlayersNumberType();
      }
      
      private function getFightFrame() : FightContextFrame
      {
         return Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
   }
}
