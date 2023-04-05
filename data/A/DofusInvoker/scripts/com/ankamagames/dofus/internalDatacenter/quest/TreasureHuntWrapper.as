package com.ankamagames.dofus.internalDatacenter.quest
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFight;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirection;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirectionToHint;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirectionToPOI;
   import com.ankamagames.dofus.types.enums.TreasureHuntStepTypeEnum;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class TreasureHuntWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TreasureHuntWrapper));
       
      
      public var questType:uint;
      
      public var checkPointCurrent:uint;
      
      public var checkPointTotal:uint;
      
      public var totalStepCount:uint;
      
      public var availableRetryCount:int;
      
      public var stepList:Vector.<TreasureHuntStepWrapper>;
      
      public function TreasureHuntWrapper()
      {
         this.stepList = new Vector.<TreasureHuntStepWrapper>();
         super();
      }
      
      public static function create(questType:uint, startMapId:Number, checkPointCurrent:uint, checkPointTotal:uint, totalStepCount:uint, availableRetryCount:int, stepList:Vector.<TreasureHuntStep>, flags:Vector.<TreasureHuntFlag>) : TreasureHuntWrapper
      {
         var step:TreasureHuntStep = null;
         var mapId:Number = NaN;
         var flagState:int = 0;
         var item:TreasureHuntWrapper = new TreasureHuntWrapper();
         item.questType = questType;
         item.checkPointCurrent = checkPointCurrent;
         item.checkPointTotal = checkPointTotal;
         item.totalStepCount = totalStepCount;
         item.availableRetryCount = availableRetryCount;
         var startStep:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START,0,0,startMapId,0);
         item.stepList.push(startStep);
         var i:int = 0;
         for each(step in stepList)
         {
            mapId = 0;
            flagState = -1;
            if(flags && flags.length > i && flags[i])
            {
               mapId = flags[i].mapId;
               flagState = flags[i].state;
            }
            if(step is TreasureHuntStepFollowDirectionToPOI)
            {
               item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI,i,(step as TreasureHuntStepFollowDirectionToPOI).direction,mapId,(step as TreasureHuntStepFollowDirectionToPOI).poiLabelId,flagState));
            }
            if(step is TreasureHuntStepFollowDirection)
            {
               item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION,i,(step as TreasureHuntStepFollowDirection).direction,mapId,0,flagState,(step as TreasureHuntStepFollowDirection).mapCount));
            }
            if(step is TreasureHuntStepFollowDirectionToHint)
            {
               item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_HINT,i,(step as TreasureHuntStepFollowDirectionToHint).direction,mapId,0,flagState,(step as TreasureHuntStepFollowDirectionToHint).npcId));
            }
            i++;
         }
         while(item.stepList.length <= totalStepCount)
         {
            item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.UNKNOWN,63,0,0,0));
         }
         item.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT,63,0,0,0));
         return item;
      }
      
      public function update(questType:uint, startMapId:Number, checkPointCurrent:uint, checkPointTotal:uint, availableRetryCount:int, stepList:Vector.<TreasureHuntStep>, flags:Vector.<TreasureHuntFlag>) : void
      {
         var step:TreasureHuntStep = null;
         var mapId:Number = NaN;
         var flagState:int = 0;
         this.questType = questType;
         this.checkPointCurrent = checkPointCurrent;
         this.checkPointTotal = checkPointTotal;
         this.totalStepCount = checkPointTotal;
         this.availableRetryCount = availableRetryCount;
         this.stepList = new Vector.<TreasureHuntStepWrapper>();
         var startStep:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START,0,0,startMapId,0);
         this.stepList.push(startStep);
         var i:int = 0;
         for each(step in stepList)
         {
            mapId = 0;
            flagState = -1;
            if(flags && flags.length > i && flags[i])
            {
               mapId = flags[i].mapId;
               flagState = flags[i].state;
            }
            if(step is TreasureHuntStepFollowDirectionToPOI)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI,i,(step as TreasureHuntStepFollowDirectionToPOI).direction,mapId,(step as TreasureHuntStepFollowDirectionToPOI).poiLabelId,flagState));
            }
            else if(step is TreasureHuntStepFollowDirectionToHint)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_HINT,i,(step as TreasureHuntStepFollowDirectionToHint).direction,mapId,0,flagState));
            }
            else if(step is TreasureHuntStepFight)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT,63,0,0,0));
            }
            i++;
         }
      }
   }
}
