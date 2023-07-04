package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.challenge.ChallengeTargetInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.challenge.ChallengeTargetWithAttackerInformation;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.interfaces.ISlotDataHolder;
   import com.ankamagames.jerakine.types.Uri;
   
   public class ChallengeWrapper implements IDataCenter, ISlotData
   {
       
      
      protected var _challenge:Challenge;
      
      protected var _id:uint;
      
      protected var _targets:Vector.<ChallengeTargetWrapper>;
      
      protected var _xpBonus:uint;
      
      protected var _dropBonus:uint;
      
      protected var _state:uint;
      
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
      
      public function setTargetsFromTargetInformation(targets:Vector.<ChallengeTargetInformation>) : void
      {
         var target:ChallengeTargetInformation = null;
         var targetWrapper:ChallengeTargetWrapper = null;
         this._targets = new Vector.<ChallengeTargetWrapper>();
         for each(target in targets)
         {
            targetWrapper = new ChallengeTargetWrapper();
            targetWrapper.targetId = target.targetId;
            targetWrapper.targetCell = target.targetCell;
            targetWrapper.targetName = this.getFightFrame().getFighterName(target.targetId);
            targetWrapper.targetLevel = this.getFightFrame().getFighterLevel(target.targetId);
            if(target is ChallengeTargetWithAttackerInformation)
            {
               targetWrapper.attackers = (target as ChallengeTargetWithAttackerInformation).attackersIds;
            }
            this._targets.push(targetWrapper);
         }
      }
      
      public function set xpBonus(bonus:uint) : void
      {
         this._xpBonus = bonus;
      }
      
      public function set dropBonus(bonus:uint) : void
      {
         this._dropBonus = bonus;
      }
      
      public function set state(state:uint) : void
      {
         this._state = state;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get xpBonus() : uint
      {
         return this._xpBonus;
      }
      
      public function get dropBonus() : uint
      {
         return this._dropBonus;
      }
      
      public function get state() : uint
      {
         return this._state;
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
      
      public function get targets() : Vector.<ChallengeTargetWrapper>
      {
         return this._targets;
      }
      
      public function get name() : String
      {
         return this._challenge.name;
      }
      
      public function get categoryId() : int
      {
         return this._challenge.categoryId;
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
      
      public function get backgroundColor() : uint
      {
         if(this.categoryId == EnumChallengeCategory.ACHIEVEMENT)
         {
            return XmlConfig.getInstance().getEntry("colors.challenge.achievement");
         }
         return XmlConfig.getInstance().getEntry("colors.challenge.challenge");
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
      
      protected function getFightFrame() : FightContextFrame
      {
         return Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
      }
   }
}
