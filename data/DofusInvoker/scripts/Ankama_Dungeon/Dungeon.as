package Ankama_Dungeon
{
   import Ankama_Dungeon.ui.BreachBossSelection;
   import Ankama_Dungeon.ui.BreachShop;
   import Ankama_Dungeon.ui.BreachTracking;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachExitRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationRequestAction;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Dungeon extends Sprite
   {
       
      
      protected var breachBossSelection:BreachBossSelection = null;
      
      protected var breachTracking:BreachTracking = null;
      
      protected var breachShop:BreachShop = null;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public function Dungeon()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(BreachHookList.BreachBranchesList,this.onBreachBranchesList);
         this.sysApi.addHook(BreachHookList.OpenBreachShop,this.onOpenBreachShop);
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.sysApi.addHook(BreachHookList.BreachState,this.onBreachState);
         this.sysApi.addHook(BreachHookList.BreachExit,this.onBreachExit);
         this.sysApi.addHook(BreachHookList.BreachInvitGroupMembers,this.onInvitGroupMembersInBreach);
      }
      
      private function onBreachBranchesList(branches:Array) : void
      {
         if(!this.uiApi.getUi("breachBossSelection"))
         {
            this.uiApi.loadUi("breachBossSelection","breachBossSelection",{"branches":branches});
         }
      }
      
      private function onOpenBreachShop(rewards:Array) : void
      {
         if(!this.uiApi.getUi("breachShop"))
         {
            this.uiApi.loadUi("breachShop","breachShop",{"rewards":rewards});
         }
      }
      
      private function onCurrentMap(pMapId:Number) : void
      {
         if(this.uiApi.getUi("breachBossSelection"))
         {
            this.uiApi.unloadUi("breachBossSelection");
         }
         if(this.uiApi.getUi("breachShop"))
         {
            this.uiApi.unloadUi("breachShop");
         }
      }
      
      private function onBreachState(owner:String, bonuses:Vector.<EffectInstanceInteger>, saved:Boolean) : void
      {
         if(!this.uiApi.getUi(UIEnum.BREACH_TRACKING))
         {
            this.uiApi.loadUi(UIEnum.BREACH_TRACKING,UIEnum.BREACH_TRACKING,{
               "owner":owner,
               "bonuses":bonuses,
               "saved":saved
            });
         }
      }
      
      private function onBreachExit() : void
      {
         this.sysApi.sendAction(new BreachExitRequestAction([]));
      }
      
      private function onInvitGroupMembersInBreach() : void
      {
         var member:PartyMemberWrapper = null;
         var allGroupMembers:Vector.<PartyMemberWrapper> = this.partyApi.getPartyMembers();
         var breachParty:Vector.<Number> = new Vector.<Number>();
         for each(member in allGroupMembers)
         {
            if(member.id != this.playerApi.id())
            {
               breachParty.push(member.id);
            }
            if(breachParty.length == 3)
            {
               break;
            }
         }
         this.sysApi.sendAction(new BreachInvitationRequestAction([breachParty]));
      }
   }
}
