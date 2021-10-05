package Ankama_GameUiCore.ui
{
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ContextAwareUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      private var _currentContext:String = "roleplay";
      
      public function ContextAwareUi()
      {
         super();
      }
      
      public function main(args:Array) : void
      {
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(FightHookList.SpectatorWantLeave,this.onSpectatorWantLeave);
      }
      
      public function get currentContext() : String
      {
         return this._currentContext;
      }
      
      public function set currentContext(pContext:String) : void
      {
         this._currentContext = pContext;
      }
      
      protected function changeContext(context:String) : void
      {
         var contextChanged:* = this._currentContext != context;
         var previousContext:String = this._currentContext;
         this._currentContext = context;
         this.onContextChanged(context,previousContext,contextChanged);
      }
      
      protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:int, fightType:int, alliesPreparation:Boolean) : void
      {
         if(isSpectator)
         {
            this.changeContext(ContextEnum.SPECTATOR);
         }
         else if(!timeMaxBeforeFightStart)
         {
            this.onGameFightStart();
         }
         else
         {
            this.changeContext(ContextEnum.PREFIGHT);
         }
      }
      
      public function onGameFightEnd(resultsKey:String) : void
      {
         this.changeContext(ContextEnum.ROLEPLAY);
      }
      
      public function onSpectatorWantLeave() : void
      {
         this.changeContext(ContextEnum.ROLEPLAY);
      }
      
      public function onGameFightStart() : void
      {
         if(this._currentContext != ContextEnum.SPECTATOR)
         {
            this.changeContext(ContextEnum.FIGHT);
         }
      }
   }
}
