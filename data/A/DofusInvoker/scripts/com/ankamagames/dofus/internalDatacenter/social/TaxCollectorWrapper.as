package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.types.game.collector.tax.AdditionalTaxCollectorInformation;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorComplementaryInformations;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorInformations;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorLootInformations;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorOrderedSpell;
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorWaitingForHelpInformations;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemGenericQuantity;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getTimer;
   
   public class TaxCollectorWrapper implements IDataCenter
   {
       
      
      public var uniqueId:Number;
      
      public var firstName:String;
      
      public var lastName:String;
      
      public var entityLook:EntityLook;
      
      public var tiphonEntityLook:TiphonEntityLook;
      
      public var alliance:AllianceWrapper;
      
      public var additionalInformation:AdditionalTaxCollectorInformation;
      
      public var mapWorldX:int;
      
      public var mapWorldY:int;
      
      public var subareaId:int;
      
      public var state:int;
      
      public var fightTime:Number;
      
      public var waitTimeForPlacement:Number;
      
      public var nbPositionPerTeam:uint;
      
      public var pods:int;
      
      public var itemsValue:Number = 0;
      
      public var collectedItems:Vector.<ObjectItemGenericQuantity>;
      
      public var callerId:Number = 0;
      
      public var callerName:String = "";
      
      public var equipments:Vector.<ObjectItem>;
      
      public var spells:Vector.<TaxCollectorOrderedSpell>;
      
      public var attackTimestamp:Number;
      
      public function TaxCollectorWrapper()
      {
         this.equipments = new Vector.<ObjectItem>();
         this.spells = new Vector.<TaxCollectorOrderedSpell>();
         super();
      }
      
      public static function create(pInformations:TaxCollectorInformations) : TaxCollectorWrapper
      {
         var item:TaxCollectorWrapper = null;
         var comp:TaxCollectorComplementaryInformations = null;
         item = new TaxCollectorWrapper();
         item.uniqueId = pInformations.uniqueId;
         item.lastName = TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         item.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firstNameId).firstname;
         item.alliance = AllianceWrapper.getFromNetwork(pInformations.allianceIdentity);
         item.additionalInformation = pInformations.additionalInfos;
         item.mapWorldX = pInformations.worldX;
         item.mapWorldY = pInformations.worldY;
         item.subareaId = pInformations.subAreaId;
         item.state = pInformations.state;
         item.entityLook = pInformations.look;
         item.tiphonEntityLook = EntityLookAdapter.fromNetwork(item.entityLook);
         item.equipments = pInformations.equipments.concat();
         item.spells = pInformations.spells.concat();
         item.fightTime = 0;
         item.waitTimeForPlacement = 0;
         item.nbPositionPerTeam = 5;
         for each(comp in pInformations.complements)
         {
            if(comp is TaxCollectorLootInformations)
            {
               item.pods = (comp as TaxCollectorLootInformations).pods;
               item.itemsValue = (comp as TaxCollectorLootInformations).itemsValue;
            }
            else if(comp is TaxCollectorWaitingForHelpInformations)
            {
               item.fightTime = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
               item.waitTimeForPlacement = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
               item.nbPositionPerTeam = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
            }
         }
         return item;
      }
      
      public function update(pInformations:TaxCollectorInformations) : void
      {
         var comp:TaxCollectorComplementaryInformations = null;
         this.uniqueId = pInformations.uniqueId;
         this.lastName = TaxCollectorName.getTaxCollectorNameById(pInformations.lastNameId).name;
         this.firstName = TaxCollectorFirstname.getTaxCollectorFirstnameById(pInformations.firstNameId).firstname;
         this.alliance = AllianceWrapper.getFromNetwork(pInformations.allianceIdentity);
         this.additionalInformation = pInformations.additionalInfos;
         this.mapWorldX = pInformations.worldX;
         this.mapWorldY = pInformations.worldY;
         this.subareaId = pInformations.subAreaId;
         this.state = pInformations.state;
         this.entityLook = pInformations.look;
         this.tiphonEntityLook = EntityLookAdapter.fromNetwork(this.entityLook);
         this.equipments = pInformations.equipments.concat();
         this.spells = pInformations.spells.concat();
         this.fightTime = 0;
         this.waitTimeForPlacement = 0;
         this.nbPositionPerTeam = 5;
         for each(comp in pInformations.complements)
         {
            if(comp is TaxCollectorLootInformations)
            {
               this.pods = (comp as TaxCollectorLootInformations).pods;
               this.itemsValue = (comp as TaxCollectorLootInformations).itemsValue;
            }
            else if(comp is TaxCollectorWaitingForHelpInformations)
            {
               this.fightTime = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.timeLeftBeforeFight * 100 + getTimer();
               this.waitTimeForPlacement = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.waitTimeForPlacement * 100;
               this.nbPositionPerTeam = (comp as TaxCollectorWaitingForHelpInformations).waitingForHelpInfo.nbPositionForDefensors;
            }
         }
      }
      
      public function addEquipment(item:ObjectItem) : void
      {
         var currentItem:ItemWrapper = null;
         var itemToAdd:ItemWrapper = ItemWrapper.create(item.position,item.objectUID,item.objectGID,item.quantity,item.effects);
         for(var i:uint = 0; i < this.equipments.length; i++)
         {
            currentItem = ItemWrapper.create(this.equipments[i].position,this.equipments[i].objectUID,this.equipments[i].objectGID,this.equipments[i].quantity,this.equipments[i].effects);
            if(currentItem.objectGID == itemToAdd.objectGID || currentItem.typeId == itemToAdd.typeId)
            {
               this.equipments[i] = item;
               return;
            }
         }
         this.equipments.push(item);
      }
      
      public function removeEquipment(item:ObjectItem) : void
      {
         var currentItem:ItemWrapper = null;
         var itemToRemove:ItemWrapper = ItemWrapper.create(item.position,item.objectUID,item.objectGID,item.quantity,item.effects);
         var index:int = -1;
         for(var i:uint = 0; i < this.equipments.length; i++)
         {
            currentItem = ItemWrapper.create(this.equipments[i].position,this.equipments[i].objectUID,this.equipments[i].objectGID,this.equipments[i].quantity,this.equipments[i].effects);
            if(currentItem.objectGID == itemToRemove.objectGID)
            {
               index = i;
               break;
            }
         }
         if(index != -1)
         {
            this.equipments.splice(index,1);
         }
      }
   }
}
