package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class PrismHookList
   {
      
      public static const PrismAddOrUpdate:String = "PrismAddOrUpdate";
      
      public static const PrismsMultipleUpdate:String = "PrismsMultipleUpdate";
      
      public static const PrismRemoved:String = "PrismRemoved";
      
      public static const KohStarting:String = "KohStarting";
      
      public static const KohState:String = "KohState";
      
      public static const PrismAttacked:String = "PrismAttacked";
      
      public static const PvpAvaStateChange:String = "PvpAvaStateChange";
       
      
      public function PrismHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(PrismAddOrUpdate);
         Hook.createHook(PrismRemoved);
         Hook.createHook(PrismsMultipleUpdate);
         Hook.createHook(KohStarting);
         Hook.createHook(KohState);
         Hook.createHook(PrismAttacked);
         Hook.createHook(PvpAvaStateChange);
      }
   }
}
