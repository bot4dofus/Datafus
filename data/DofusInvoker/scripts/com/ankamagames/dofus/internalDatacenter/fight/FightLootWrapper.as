package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.types.game.context.fight.FightLoot;
   import com.ankamagames.dofus.network.types.game.context.fight.FightLootObject;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FightLootWrapper implements IDataCenter
   {
       
      
      public var objects:Array;
      
      public var kamas:Number = 0;
      
      public function FightLootWrapper(loot:FightLoot)
      {
         var reward:FightLootObject = null;
         super();
         this.objects = new Array();
         for each(reward in loot.objects)
         {
            this.objects.push(ItemWrapper.create(63,0,reward.objectId,reward.quantity,new Vector.<ObjectEffect>(),false,reward.priorityHint));
         }
         this.kamas = loot.kamas;
      }
   }
}
