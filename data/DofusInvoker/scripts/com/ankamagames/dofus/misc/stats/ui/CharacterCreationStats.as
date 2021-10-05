package com.ankamagames.dofus.misc.stats.ui
{
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.breeds.Head;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatisticsManager;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.GameDataQuery;
   import com.ankamagames.dofus.network.enums.CharacterCreationResultEnum;
   import com.ankamagames.dofus.network.messages.game.character.creation.CharacterCreationResultMessage;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.messages.Message;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class CharacterCreationStats implements IUiStats, IHookStats
   {
       
      
      private var _action:StatsAction;
      
      private var _action2:StatsAction;
      
      private var _ui:UiRootContainer;
      
      private var _timeoutId:uint;
      
      private var _createAttempts:uint = 1;
      
      public function CharacterCreationStats(pUi:UiRootContainer)
      {
         super();
         this._ui = pUi;
         var exists:Boolean = StatsAction.exists(InternalStatisticTypeEnum.SERVER_LIST_SELECTION);
         this._action = StatsAction.get(InternalStatisticTypeEnum.SERVER_LIST_SELECTION,false,false,true);
         if(!exists)
         {
            this._action.setParam("account_id",PlayerManager.getInstance().accountId);
            this._action.setParam("step_id",100);
            this._action.setParam("automatic_choice",true);
            this._action.setParam("seek_a_friend",false);
            this._action.setParam("server_id",PlayerManager.getInstance().server.id);
         }
         this._action.setParam("seek_informations",false);
         this._action.start();
         this._action2 = StatsAction.get(InternalStatisticTypeEnum.CHARACTER_CREATION,false,false,true);
         this._action2.setParam("account_id",this._action.params["account_id"]);
         this._action2.setParam("server_id",this._action.params["server_id"]);
         this._action2.setParam("gender",this._action.params["gender"]);
         this._action2.setParam("used_style_generator",false);
         this._action2.setParam("used_name_generator",false);
         this._action2.setParam("show_hover",false);
         this._action2.setParam("create_success",false);
         this._action2.setParam("create_error",null);
         this._action2.setParam("create_attempts",this._createAttempts);
         this._action2.setParam("create_name",null);
         this._action2.setParam("step_id",200);
         this._action2.start();
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var ccmsg:CharacterCreationResultMessage = null;
         var ermsg:EntityReadyMessage = null;
         var entityDisplay:EntityDisplayer = null;
         var errorMsg:String = null;
         var target:GraphicContainer = !!pArgs ? pArgs[1] : null;
         switch(true)
         {
            case pMessage is CharacterCreationAction:
               this._action2.setParam("create_name",(pMessage as CharacterCreationAction).name);
               break;
            case pMessage is CharacterCreationResultMessage:
               ccmsg = pMessage as CharacterCreationResultMessage;
               if(ccmsg.result > 0)
               {
                  switch(ccmsg.result)
                  {
                     case CharacterCreationResultEnum.ERR_INVALID_NAME:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.invalidName");
                        break;
                     case CharacterCreationResultEnum.ERR_NAME_ALREADY_EXISTS:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.nameAlreadyExist");
                        break;
                     case CharacterCreationResultEnum.ERR_NOT_ALLOWED:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.notSubscriber");
                        break;
                     case CharacterCreationResultEnum.ERR_TOO_MANY_CHARACTERS:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.tooManyCharacters");
                        break;
                     case CharacterCreationResultEnum.ERR_NO_REASON:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.noReason");
                        break;
                     case CharacterCreationResultEnum.ERR_RESTRICED_ZONE:
                        errorMsg = I18n.getUiText("ui.charSel.deletionErrorUnsecureMode");
                        break;
                     case CharacterCreationResultEnum.ERR_INCONSISTENT_COMMUNITY:
                        errorMsg = I18n.getUiText("ui.popup.charcrea.wrongCommunity");
                  }
                  this._action2.setParam("create_error",errorMsg.substr(0,100));
               }
               else
               {
                  this._action2.setParam("create_success",true);
                  StatisticsManager.getInstance().setFirstTimeUserExperience("serverListSelection",false);
                  StatisticsManager.getInstance().setFirstTimeUserExperience(this._ui.name,false);
               }
               this._action2.send();
               ++this._createAttempts;
               this._action2.setParam("create_attempts",this._createAttempts);
               break;
            case pMessage is EntityReadyMessage:
               ermsg = pMessage as EntityReadyMessage;
               entityDisplay = ermsg.target as EntityDisplayer;
               this._action.setParam("breed_id",entityDisplay.look.skins[0]);
               this._action.setParam("gender",this._ui.uiClass.btn_breedSex0.selected || this._ui.uiClass.btn_customSex0.selected ? "m" : "f");
               this._action.setParam("change_gender",this._action.params["gender"] != "m");
               this._action2.setParam("breed_id",entityDisplay.look.skins[0]);
               this._action2.setParam("face_chosen",GameDataQuery.queryString(Head,"skins",String(entityDisplay.look.skins[1]))[0]);
               break;
            case pMessage is CharacterNameSuggestionRequestAction:
               this._action2.setParam("used_name_generator",true);
               break;
            case pMessage is MouseClickMessage:
               switch(target.name)
               {
                  case "btn_generateColor":
                     this._action2.setParam("used_style_generator",true);
                     break;
                  case "btn_breedSex0":
                  case "btn_customSex0":
                     this._action.setParam("gender","m");
                     this._action2.setParam("gender","m");
                     break;
                  case "btn_breedSex1":
                  case "btn_customSex1":
                     this._action.setParam("gender","f");
                     this._action.setParam("change_gender",true);
                     this._action2.setParam("gender","f");
                     break;
                  case "btn_breedInfo":
                     this._action.setParam("seek_informations",true);
                     break;
                  case "btn_next":
                     if(this._ui.uiClass.btn_lbl_btn_next.text == I18n.getUiText("ui.charcrea.selectClass").toLocaleUpperCase())
                     {
                        this._action.send();
                     }
               }
               break;
            case pMessage is MouseOverMessage:
               if(target.name == "tx_nameRules")
               {
                  this._timeoutId = setTimeout(this.showNamesRulesTooltip,1000);
               }
               break;
            case pMessage is MouseOutMessage:
               if(target.name == "tx_nameRules")
               {
                  clearTimeout(this._timeoutId);
               }
         }
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
      }
      
      public function remove() : void
      {
      }
      
      private function showNamesRulesTooltip() : void
      {
         this._action2.setParam("show_hover",true);
      }
   }
}
