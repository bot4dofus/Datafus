package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.network.types.game.context.fight.FightLoot;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class FightLootWrapper implements IDataCenter
   {
       
      
      public var objects:Array;
      
      public var kamas:Number = 0;
      
      public function FightLootWrapper(loot:FightLoot)
      {
         super();
         this.objects = new Array();
         for(var i:uint = 0; i < loot.objects.length; i += 2)
         {
            this.objects.push(ItemWrapper.create(63,0,loot.objects[i],loot.objects[i + 1],new Vector.<ObjectEffect>(),false));
         }
         this.kamas = loot.kamas;
      }
   }
}
