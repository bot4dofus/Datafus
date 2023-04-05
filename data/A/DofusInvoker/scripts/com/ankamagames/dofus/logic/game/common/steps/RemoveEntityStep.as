package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRemoveElementMessage;
   import com.ankamagames.dofus.scripts.api.EntityApi;
   import com.ankamagames.jerakine.lua.LuaPlayer;
   import com.ankamagames.jerakine.script.ScriptsManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   
   public class RemoveEntityStep extends AbstractSequencable
   {
       
      
      private var _id:Number;
      
      public function RemoveEntityStep(pEntityId:Number)
      {
         super();
         this._id = pEntityId;
      }
      
      override public function start() : void
      {
         var luaEntityApi:EntityApi = null;
         var gcrem:GameContextRemoveElementMessage = new GameContextRemoveElementMessage();
         gcrem.initGameContextRemoveElementMessage(this._id);
         Kernel.getWorker().process(gcrem);
         var luaPlayer:LuaPlayer = ScriptsManager.getInstance().getPlayer(ScriptsManager.LUA_PLAYER) as LuaPlayer;
         if(luaPlayer)
         {
            luaEntityApi = ScriptsManager.getInstance().getPlayerApi(luaPlayer,"EntityApi") as EntityApi;
            if(luaEntityApi)
            {
               luaEntityApi.removeEntity(this._id);
            }
         }
         executeCallbacks();
      }
   }
}
