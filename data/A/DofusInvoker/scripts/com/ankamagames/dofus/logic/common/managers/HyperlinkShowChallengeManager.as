package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.internalDatacenter.fight.ChallengeWrapper;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeCategory;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowChallengeManager
   {
      
      public static const LEFT_SEPARATOR:String = "[";
      
      public static const RIGHT_SEPARATOR:String = "]";
      
      public static const SEPARATOR:String = ",";
      
      public static const CHALLENGE_LABEL:String = "challenge";
      
      public static const MAX_ITERATION_COUNT:uint = 1000;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowChallengeManager));
       
      
      public function HyperlinkShowChallengeManager()
      {
         super();
      }
      
      public static function getLink(challenge:Challenge, linkColor:String = null, hoverColor:String = null) : String
      {
         linkColor = !!linkColor ? ",linkColor:" + linkColor : "";
         hoverColor = !!hoverColor ? ",hoverColor:" + hoverColor : "";
         return "{challenge," + challenge.id + linkColor + hoverColor + "::[" + challenge.name + "]}";
      }
      
      public static function rollOver(xPos:int, yPos:int, objectGID:uint, challengeId:uint = 0) : void
      {
         var params:Object = null;
         var achievements:Vector.<Achievement> = null;
         var target:Rectangle = new Rectangle(xPos,yPos,10,10);
         var challenge:Challenge = Challenge.getChallengeById(objectGID);
         if(challenge === null)
         {
            return;
         }
         if(EnumChallengeCategory.isAchievementCategoryId(challenge.categoryId))
         {
            achievements = challenge.boundAchievements;
            params = {
               "name":challenge.name,
               "description":challenge.description,
               "boundAchievements":achievements
            };
         }
         else
         {
            params = {
               "name":true,
               "description":true,
               "effects":true
            };
         }
         var bossId:Number = challenge.getTargetMonsterId();
         if(!isNaN(bossId))
         {
            params.bossId = bossId;
         }
         var turnsRequired:Number = challenge.getTurnsNumberForCompletion();
         if(!isNaN(turnsRequired))
         {
            params.turnsRequired = turnsRequired;
         }
         var challengeWrapper:ChallengeWrapper = ChallengeWrapper.create();
         challengeWrapper.id = challenge.id;
         TooltipManager.show(challengeWrapper,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,0,true,"challenge",null,params,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
      
      public static function parseChallengeLinks(text:String, linkColor:String = null, hoverColor:String = null) : String
      {
         var currentLeftSeparatorPos:Number = NaN;
         var currentRightSeparatorPos:Number = NaN;
         var challengeLabel:String = null;
         var challengeId:Number = NaN;
         var challenge:Challenge = null;
         if(!text)
         {
            return null;
         }
         var rawText:String = text;
         var processedText:String = "";
         var tmpText:String = null;
         var tmpArray:Array = null;
         var iterationCount:uint = 0;
         while(rawText && iterationCount <= MAX_ITERATION_COUNT)
         {
            challengeLabel = null;
            challengeId = Number.NaN;
            challenge = null;
            currentLeftSeparatorPos = rawText.indexOf(LEFT_SEPARATOR);
            currentRightSeparatorPos = getRightSeparatorPos(currentLeftSeparatorPos,rawText);
            if(currentLeftSeparatorPos === -1)
            {
               processedText += rawText;
               iterationCount++;
               break;
            }
            if(currentRightSeparatorPos === -1)
            {
               processedText += rawText.substr(0,currentLeftSeparatorPos);
               rawText = rawText.substr(currentLeftSeparatorPos + 1);
               iterationCount++;
            }
            else
            {
               processedText += rawText.substr(0,currentLeftSeparatorPos);
               tmpText = rawText.substr(currentLeftSeparatorPos + 1,currentRightSeparatorPos - currentLeftSeparatorPos - 1);
               if(tmpText)
               {
                  if(tmpText.indexOf(LEFT_SEPARATOR) !== -1)
                  {
                     processedText += LEFT_SEPARATOR;
                     rawText = rawText.substr(currentLeftSeparatorPos + 1);
                     iterationCount++;
                     continue;
                  }
                  tmpArray = tmpText.split(SEPARATOR);
                  if(tmpArray !== null && tmpArray.length === 2)
                  {
                     challengeLabel = tmpArray[0];
                     challengeId = Number(tmpArray[1]);
                     challenge = Challenge.getChallengeById(challengeId);
                  }
                  if(challengeLabel !== CHALLENGE_LABEL || isNaN(challengeId) || challenge === null)
                  {
                     processedText += rawText.substr(currentLeftSeparatorPos,currentRightSeparatorPos - currentLeftSeparatorPos + 1);
                  }
                  else
                  {
                     processedText += getLink(challenge,linkColor,hoverColor);
                  }
               }
               if(currentRightSeparatorPos >= rawText.length - 1)
               {
                  break;
               }
               rawText = rawText.substr(currentRightSeparatorPos + 1);
               iterationCount++;
            }
         }
         if(iterationCount > MAX_ITERATION_COUNT)
         {
            _log.error("Max iteration count (" + MAX_ITERATION_COUNT.toString() + ") reached while parsing \'" + text + "\'");
         }
         return processedText;
      }
      
      private static function getRightSeparatorPos(startPos:Number, text:String) : Number
      {
         if(isNaN(startPos) || startPos < 0 || !text && startPos + 1 > text.length)
         {
            return -1;
         }
         var index:Number = startPos + 1;
         var maxLength:int = text.length;
         var leftSeparatorFoundNumber:int = 0;
         var character:String = null;
         var indexFound:Number = -1;
         for(; index < maxLength; index++)
         {
            character = text.charAt(index);
            if(character === LEFT_SEPARATOR)
            {
               leftSeparatorFoundNumber++;
            }
            else if(character === RIGHT_SEPARATOR)
            {
               if(leftSeparatorFoundNumber <= 0)
               {
                  indexFound = index;
               }
               leftSeparatorFoundNumber--;
               continue;
               break;
            }
         }
         return indexFound;
      }
   }
}
