package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class BreachHookList
   {
      
      public static const BreachBranchesList:String = "BreachBranchesList";
      
      public static const BreachState:String = "BreachState";
      
      public static const BreachBonus:String = "BreachBonus";
      
      public static const BreachErosion:String = "BreachErosion";
      
      public static const BreachBudget:String = "BreachBudget";
      
      public static const BreachSaved:String = "BreachSaved";
      
      public static const BreachMapInfos:String = "BreachMapInfos";
      
      public static const OpenBreachShop:String = "OpenBreachShop";
      
      public static const BreachSaveBought:String = "BreachSaveBought";
      
      public static const BreachRewardBought:String = "BreachRewardBought";
      
      public static const BreachExit:String = "BreachExit";
      
      public static const BreachInvitGroupMembers:String = "BreachInvitGroupMembers";
      
      public static const BreachCharactersListUpdate:String = "BreachCharactersListUpdate";
      
      public static const BreachBuyRoom:String = "BreachBuyRoom";
       
      
      public function BreachHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(BreachBranchesList);
         Hook.createHook(BreachState);
         Hook.createHook(BreachBonus);
         Hook.createHook(BreachErosion);
         Hook.createHook(BreachBudget);
         Hook.createHook(BreachSaved);
         Hook.createHook(BreachMapInfos);
         Hook.createHook(OpenBreachShop);
         Hook.createHook(BreachSaveBought);
         Hook.createHook(BreachRewardBought);
         Hook.createHook(BreachExit);
         Hook.createHook(BreachInvitGroupMembers);
         Hook.createHook(BreachCharactersListUpdate);
         Hook.createHook(BreachBuyRoom);
      }
   }
}
