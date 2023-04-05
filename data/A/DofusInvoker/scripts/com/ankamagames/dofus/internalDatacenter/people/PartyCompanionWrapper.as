package com.ankamagames.dofus.internalDatacenter.people
{
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PartyCompanionWrapper extends PartyMemberWrapper implements IDataCenter
   {
       
      
      public var companionGenericId:uint = 0;
      
      public var index:uint = 0;
      
      public var masterName:String = "";
      
      public function PartyCompanionWrapper(masterId:Number, masterName:String, companionGenericId:int, isMember:Boolean, level:int = 0, entityLook:EntityLook = null, lifePoints:int = 0, maxLifePoints:int = 0, maxInitiative:int = 0, prospecting:int = 0, regenRate:int = 0)
      {
         var name:String = null;
         var genericName:String = Companion.getCompanionById(companionGenericId).name;
         if(masterId != PlayedCharacterManager.getInstance().id)
         {
            name = I18n.getUiText("ui.common.belonging",[genericName,masterName]);
         }
         else
         {
            name = genericName;
         }
         super(masterId,name,0,isMember,false,level,entityLook,lifePoints,maxLifePoints,maxInitiative,prospecting,0,regenRate,0,0,0,0,0,0,null);
         this.companionGenericId = companionGenericId;
         this.masterName = masterName;
      }
      
      override public function get initiative() : int
      {
         return maxInitiative;
      }
   }
}
