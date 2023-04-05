package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public class SocialEntityInFightWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SocialEntityInFightWrapper));
       
      
      public var mapId:Number;
      
      public var fightId:Number;
      
      public var typeId:int;
      
      public var allyCharactersInformations:Array;
      
      public var enemyCharactersInformations:Array;
      
      public var nextPhaseTime:Number;
      
      public var fightPhase:uint;
      
      public var look:TiphonEntityLook;
      
      public function SocialEntityInFightWrapper()
      {
         super();
      }
      
      public static function create(pType:int, pMapId:Number, pFightId:Number, pAllies:Array = null, pEnemies:Array = null, pFightPhase:uint = 0, pNextPhaseTime:Number = 0) : SocialEntityInFightWrapper
      {
         var item:SocialEntityInFightWrapper = null;
         var ally:CharacterMinimalPlusLookInformations = null;
         var enemy:CharacterMinimalPlusLookInformations = null;
         item = new SocialEntityInFightWrapper();
         item.allyCharactersInformations = [];
         item.enemyCharactersInformations = [];
         item.typeId = pType;
         item.mapId = pMapId;
         item.fightId = pFightId;
         item.fightPhase = pFightPhase;
         item.nextPhaseTime = pNextPhaseTime;
         for each(ally in pAllies)
         {
            item.allyCharactersInformations.push(SocialFightersWrapper.create(0,ally));
         }
         for each(enemy in pEnemies)
         {
            item.enemyCharactersInformations.push(SocialFightersWrapper.create(1,enemy));
         }
         return item;
      }
      
      public function update(pType:int, pMapId:Number, pFightId:Number, pAllies:Array, pEnemies:Array, pFightPhase:uint, pNextPhaseTime:Number = 0) : void
      {
         var ally:SocialFightersWrapper = null;
         var enemy:SocialFightersWrapper = null;
         this.allyCharactersInformations = [];
         this.enemyCharactersInformations = [];
         this.typeId = pType;
         this.mapId = pMapId;
         this.fightId = pFightId;
         this.fightPhase = pFightPhase;
         this.nextPhaseTime = pNextPhaseTime;
         for each(ally in pAllies)
         {
            this.allyCharactersInformations.push(SocialFightersWrapper.create(0,ally.playerCharactersInformations));
         }
         for each(enemy in pEnemies)
         {
            this.enemyCharactersInformations.push(SocialFightersWrapper.create(1,enemy.playerCharactersInformations));
         }
      }
      
      public function updateEntityLook(info:CharacterMinimalPlusLookInformations) : void
      {
         this.look = EntityLookAdapter.fromNetwork(info.entityLook);
      }
      
      public function getFightUniqueId() : String
      {
         return this.mapId + "" + this.fightId;
      }
   }
}
