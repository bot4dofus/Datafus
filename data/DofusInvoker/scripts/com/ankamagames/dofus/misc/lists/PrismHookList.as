package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class PrismHookList
   {
      
      public static const PrismsList:String = "PrismsList";
      
      public static const PrismsListUpdate:String = "PrismsListUpdate";
      
      public static const KohStarting:String = "KohStarting";
      
      public static const KohState:String = "KohState";
      
      public static const PrismAttacked:String = "PrismAttacked";
      
      public static const PrismInFightAdded:String = "PrismInFightAdded";
      
      public static const PrismInFightRemoved:String = "PrismInFightRemoved";
      
      public static const PrismsInFightList:String = "PrismsInFightList";
      
      public static const PvpAvaStateChange:String = "PvpAvaStateChange";
       
      
      public function PrismHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(PrismsList);
         Hook.createHook(PrismsListUpdate);
         Hook.createHook(KohStarting);
         Hook.createHook(KohState);
         Hook.createHook(PrismAttacked);
         Hook.createHook(PrismInFightAdded);
         Hook.createHook(PrismInFightRemoved);
         Hook.createHook(PrismsInFightList);
         Hook.createHook(PvpAvaStateChange);
      }
   }
}
