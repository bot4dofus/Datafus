package Ankama_Roleplay.ui
{
   import Ankama_Roleplay.Roleplay;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcDialogReplyAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   public class NpcDialog
   {
      
      private static const ENTITY_FILTER:GlowFilter = new GlowFilter(0,0.4,8,8,2,BitmapFilterQuality.HIGH);
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      private var _npc:Object;
      
      private var _replies:Vector.<uint>;
      
      private var _moreReplies:Vector.<uint>;
      
      private var _currentMsg:uint;
      
      private var _aLblReplies:Array;
      
      private var _aReplies:Array;
      
      private var _aRepliesIdFromBtn:Array;
      
      private var _lockAndWaitAnswers:Boolean = false;
      
      private var _comeBackNeeded:Boolean = false;
      
      private var _continueNeeded:Boolean = false;
      
      private var _textParams:Array;
      
      private var _colorOver:Object;
      
      private var _currentSelectedAnswer:int = -1;
      
      private var _lastAnswerIndex:int = -1;
      
      private var _contentHeight:int;
      
      public var mainNpcCtr:GraphicContainer;
      
      public var repliesContainer:GraphicContainer;
      
      public var ctr_content:ScrollContainer;
      
      public var entityDisplayer_npc:EntityDisplayer;
      
      public var tx_background:Texture;
      
      public var tx_mask:Texture;
      
      public var tx_deco:Texture;
      
      public var tx_highlight_top:Texture;
      
      public var tx_highlight_bottom:Texture;
      
      public var btn_close:Texture;
      
      public var lbl_title:Label;
      
      public var lbl_message:Label;
      
      public var lbl_hidden:Label;
      
      public var btn_rep0:ButtonContainer;
      
      public var btn_rep1:ButtonContainer;
      
      public var btn_rep2:ButtonContainer;
      
      public var btn_rep3:ButtonContainer;
      
      public var btn_rep4:ButtonContainer;
      
      public var lbl_rep0:Label;
      
      public var lbl_rep1:Label;
      
      public var lbl_rep2:Label;
      
      public var lbl_rep3:Label;
      
      public var lbl_rep4:Label;
      
      public var tx_over0:Texture;
      
      public var tx_over1:Texture;
      
      public var tx_over2:Texture;
      
      public var tx_over3:Texture;
      
      public var tx_over4:Texture;
      
      public function NpcDialog()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var animation:String = null;
         this.tx_background.addContent(this.tx_mask);
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         this.sysApi.addHook(RoleplayHookList.NpcDialogQuestion,this.onNpcDialogQuestion);
         this.sysApi.addHook(SocialHookList.TaxCollectorDialogQuestionExtended,this.onTaxCollectorDialogQuestionExtended);
         this.sysApi.addHook(SocialHookList.AllianceTaxCollectorDialogQuestionExtended,this.onAllianceTaxCollectorDialogQuestionExtended);
         this.sysApi.addHook(SocialHookList.TaxCollectorDialogQuestionBasic,this.onTaxCollectorDialogQuestionBasic);
         this.sysApi.addHook(SocialHookList.AlliancePrismDialogQuestion,this.onAlliancePrismDialogQuestion);
         this.sysApi.addHook(RoleplayHookList.PortalDialogQuestion,this.onPortalDialogQuestion);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("upArrow",this.onShortcut);
         this.uiApi.addShortcutHook("downArrow",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_rep0,"onRollOver");
         this.uiApi.addComponentHook(this.btn_rep0,"onRollOut");
         this.uiApi.addComponentHook(this.btn_rep1,"onRollOver");
         this.uiApi.addComponentHook(this.btn_rep1,"onRollOut");
         this.uiApi.addComponentHook(this.btn_rep2,"onRollOver");
         this.uiApi.addComponentHook(this.btn_rep2,"onRollOut");
         this.uiApi.addComponentHook(this.btn_rep3,"onRollOver");
         this.uiApi.addComponentHook(this.btn_rep3,"onRollOut");
         this.uiApi.addComponentHook(this.btn_rep4,"onRollOver");
         this.uiApi.addComponentHook(this.btn_rep4,"onRollOut");
         this.uiApi.addComponentHook(this.btn_rep0,"onRelease");
         this.uiApi.addComponentHook(this.btn_rep1,"onRelease");
         this.uiApi.addComponentHook(this.btn_rep2,"onRelease");
         this.uiApi.addComponentHook(this.btn_rep3,"onRelease");
         this.uiApi.addComponentHook(this.btn_rep4,"onRelease");
         this.uiApi.addComponentHook(this.entityDisplayer_npc,"onEntityReady");
         this._colorOver = this.uiApi.getColor(this.sysApi.getConfigEntry("colors.combobox.over"));
         if(this.entityDisplayer_npc.hasAnimation(params[1].getBone(),"AnimDialogue",1))
         {
            animation = "AnimDialogue";
         }
         else
         {
            animation = "AnimStatique";
         }
         this.entityDisplayer_npc.setAnimationAndDirection(animation,1);
         this.entityDisplayer_npc.look = params[1];
         this.ctr_content.verticalScrollSpeed = 4;
         this._npc = this.dataApi.getNpc(params[0]);
         this._textParams = [];
         if(this.playerApi.getPlayedCharacterInfo().sex == 0)
         {
            this._textParams["m"] = true;
            this._textParams["f"] = false;
         }
         else
         {
            this._textParams["m"] = false;
            this._textParams["f"] = true;
         }
         if(this._npc.gender == 0)
         {
            this._textParams["n"] = true;
            this._textParams["g"] = false;
         }
         else
         {
            this._textParams["n"] = false;
            this._textParams["g"] = true;
         }
         if(params[0] == 1)
         {
            this.lbl_title.text = this.dataApi.getTaxCollectorFirstname(params[2]).firstname + " " + this.dataApi.getTaxCollectorName(params[3]).name;
         }
         else if(params[0] == 2141)
         {
            this.lbl_title.text = this.uiApi.getText("ui.zaap.prism");
         }
         else
         {
            this.lbl_title.text = this._npc.name;
            this.lbl_hidden.visible = false;
            this._aLblReplies = [this.lbl_rep0,this.lbl_rep1,this.lbl_rep2,this.lbl_rep3,this.lbl_rep4];
            this._aReplies = [this.btn_rep0,this.btn_rep1,this.btn_rep2,this.btn_rep3,this.btn_rep4];
            this._aRepliesIdFromBtn = [];
            if(Roleplay.questions.length > 0)
            {
               this.onNpcDialogQuestion(Roleplay.questions[0].messageId,Roleplay.questions[0].dialogParams,Roleplay.questions[0].visibleReplies);
            }
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this.sysApi.removeEventListener(this.onEnterFrame);
         this.sysApi.enableWorldInteraction();
      }
      
      private function displayReplies(replies:Vector.<uint>, hasMoreToShow:Boolean = false) : void
      {
         var gne:* = undefined;
         var rep:* = undefined;
         var lbl:* = undefined;
         var j:int = 0;
         var mouseX:int = 0;
         var mouseY:int = 0;
         var btn:ButtonContainer = null;
         var rect:Rectangle = null;
         var rect2:Rectangle = null;
         var nbReplies:int = 0;
         var reply:* = undefined;
         var replyId:int = 0;
         var replyTextId:int = 0;
         var posY:int = 0;
         var maxHeight:int = 400;
         var currentRepliesHeight:int = 0;
         this._continueNeeded = hasMoreToShow;
         this._contentHeight = this.lbl_message.height + 10;
         this.lbl_hidden.text = "";
         for(gne in this._aLblReplies)
         {
            this._aReplies[gne].y = 0;
            this._aLblReplies[gne].text = "";
            this._aRepliesIdFromBtn[gne] = 0;
            this["tx_over" + gne].height = 10;
            this["tx_over" + gne].y = 0;
         }
         if(replies.length == 0)
         {
            this._aLblReplies[0].text = this.uiApi.getText("ui.npc.closeDialog");
            currentRepliesHeight += this._aLblReplies[0].height + 5;
            this._aRepliesIdFromBtn[0] = -1;
         }
         var i:uint = 0;
         for each(rep in replies)
         {
            for each(reply in this._npc.dialogReplies)
            {
               replyId = reply[0];
               replyTextId = reply[1];
               if(replyId == rep)
               {
                  this.lbl_hidden.text = this.uiApi.decodeText(this.uiApi.getTextFromKey(replyTextId),this._textParams);
                  if(i != 0)
                  {
                     this._aReplies[i].state = 0;
                     posY = this._aReplies[i - 1].y + this._aReplies[i - 1].height;
                     this._aReplies[i].y = posY;
                  }
                  if(currentRepliesHeight + this.lbl_hidden.height + 5 > maxHeight)
                  {
                     hasMoreToShow = true;
                     i++;
                     break;
                  }
                  this._aLblReplies[i].text = this.lbl_hidden.htmlText;
                  currentRepliesHeight += this._aLblReplies[i].height + 5;
                  this._aRepliesIdFromBtn[i] = replyId;
               }
            }
            i++;
         }
         if(hasMoreToShow)
         {
            this._aReplies[i].state = 0;
            this._aLblReplies[i].text = this.uiApi.getText("ui.npc.showMore");
            this._aReplies[i].y = this._aReplies[i - 1].y + this._aReplies[i - 1].height;
            this._aReplies[i].reset();
         }
         else if(this._comeBackNeeded)
         {
            this._aReplies[i].state = 0;
            this._aLblReplies[i].text = this.uiApi.getText("ui.common.restart");
            this._aReplies[i].y = this._aReplies[i - 1].y + this._aReplies[i - 1].height;
            this._aReplies[i].reset();
         }
         this._lastAnswerIndex = -1;
         this._currentSelectedAnswer = -1;
         for(lbl in this._aLblReplies)
         {
            this.unselectAnswer(int(lbl));
            if(this._aLblReplies[lbl].text == "")
            {
               this._aReplies[lbl].state = 0;
               this._aReplies[lbl].visible = false;
               this._aReplies[lbl].reset();
            }
            else
            {
               this._lastAnswerIndex = int(lbl);
               this._aReplies[lbl].visible = true;
               this._contentHeight += (this._aLblReplies[lbl] as Label).contentHeight + 5;
            }
         }
         this.refreshBackground();
         mouseX = this.uiApi.getMouseX();
         mouseY = this.uiApi.getMouseY();
         nbReplies = replies.length;
         for(j = 0; j < nbReplies; j++)
         {
            btn = this["btn_rep" + j];
            rect = btn.getStageRect();
            rect2 = new Rectangle(rect.x,rect.y,rect.width,rect.height);
            if(rect2.contains(mouseX,mouseY))
            {
               this.selectAnswer(j);
               break;
            }
         }
         this.sysApi.dispatchHook(HookList.NpcDialogRepliesVisible,true);
      }
      
      private function showMore() : void
      {
         if(this._continueNeeded)
         {
            this._comeBackNeeded = true;
            if(this._moreReplies.length > 4)
            {
               this.displayReplies(this._moreReplies.slice(0,4),true);
               this._moreReplies = this._moreReplies.slice(4);
            }
            else
            {
               this.displayReplies(this._moreReplies);
            }
         }
         else if(this._comeBackNeeded)
         {
            this._comeBackNeeded = false;
            this.displayReplies(this._replies.slice(0,4),true);
            this._moreReplies = this._replies.slice(4);
         }
      }
      
      private function selectAnswer(i:int) : void
      {
         if(!this._aReplies || this._aReplies.length == 0)
         {
            return;
         }
         this["tx_over" + i].x = this._aReplies[i].x;
         this["tx_over" + i].y = this._aReplies[i].y;
         this["tx_over" + i].width = this._aReplies[i].width;
         this["tx_over" + i].height = this._aReplies[i].height;
         this["tx_over" + i].bgColor = this._colorOver.color;
         this["tx_over" + i].bgAlpha = !!this._colorOver.hasOwnProperty("alpha") ? this._colorOver.alpha : 1;
         this._currentSelectedAnswer = i;
      }
      
      private function unselectAnswer(i:int) : void
      {
         this["tx_over" + i].bgColor = -1;
      }
      
      private function refreshBackground() : void
      {
         this.tx_mask.y = this.uiApi.getStageHeight() - 200 - (this.ctr_content.height + 95);
         this.tx_background.mask = this.tx_mask;
         this.mainNpcCtr.x = this.uiApi.getStartWidth() / 2 - this.mainNpcCtr.width / 2;
         this.mainNpcCtr.y = this.uiApi.getStartHeight() - 200 - this.tx_background.height;
         this.tx_highlight_top.y = this.tx_mask.y - this.tx_highlight_top.height + 17;
         this.tx_highlight_bottom.y = this.uiApi.getStageHeight() - 200 + this.tx_highlight_bottom.height - 4;
         this.btn_close.y = this.tx_deco.y = this.tx_mask.y + 15;
         this.lbl_title.y = this.tx_mask.y + 22;
         this.ctr_content.y = this.tx_mask.y + 66;
         if(!this.mainNpcCtr.visible)
         {
            this.sysApi.addEventListener(this.onEnterFrame,"refreshBackground");
         }
      }
      
      private function onEnterFrame(e:Event) : void
      {
         if(!this.tx_background)
         {
            return;
         }
         this.tx_background.visible = true;
         this.mainNpcCtr.visible = true;
         this.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function onEntityReady(target:EntityDisplayer) : void
      {
         var bounds:Rectangle = null;
         if(target == this.entityDisplayer_npc)
         {
            this.entityDisplayer_npc.fixedWidth = 270;
            if(this.entityDisplayer_npc.getEntityBounds().height > 500)
            {
               this.entityDisplayer_npc.fixedHeight = 500;
            }
            this.entityDisplayer_npc.filters = [ENTITY_FILTER];
            bounds = this.entityDisplayer_npc.getEntityBounds();
            this.entityDisplayer_npc.x -= bounds.x - 20 - (270 / 2 - bounds.width / 2);
            this.entityDisplayer_npc.y -= bounds.y + (bounds.height - this.tx_background.height);
            this.entityDisplayer_npc.visible = true;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(this._lockAndWaitAnswers)
         {
            return;
         }
         switch(target)
         {
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               break;
            case this.btn_rep0:
               if(this._aRepliesIdFromBtn[0])
               {
                  if(this._aRepliesIdFromBtn[0] >= 0)
                  {
                     this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[0]]));
                     this._lockAndWaitAnswers = true;
                  }
                  else
                  {
                     this.sysApi.sendAction(new LeaveDialogRequestAction([]));
                  }
                  this._comeBackNeeded = false;
               }
               else
               {
                  this.showMore();
               }
               break;
            case this.btn_rep1:
               if(this._aRepliesIdFromBtn[1])
               {
                  this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[1]]));
                  this._lockAndWaitAnswers = true;
                  this._comeBackNeeded = false;
               }
               else
               {
                  this.showMore();
               }
               break;
            case this.btn_rep2:
               if(this._aRepliesIdFromBtn[2])
               {
                  this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[2]]));
                  this._lockAndWaitAnswers = true;
                  this._comeBackNeeded = false;
               }
               else
               {
                  this.showMore();
               }
               break;
            case this.btn_rep3:
               if(this._aRepliesIdFromBtn[3])
               {
                  this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[3]]));
                  this._lockAndWaitAnswers = true;
                  this._comeBackNeeded = false;
               }
               else
               {
                  this.showMore();
               }
               break;
            case this.btn_rep4:
               if(this._aRepliesIdFromBtn[4])
               {
                  this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[4]]));
                  this._lockAndWaitAnswers = true;
                  this._comeBackNeeded = false;
               }
               else
               {
                  this.showMore();
               }
         }
         this.onRollOut(target);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var answerIndex:int = 0;
         var answerIndex2:int = 0;
         switch(s)
         {
            case "validUi":
               if(this._currentSelectedAnswer == 0)
               {
                  if(this._aRepliesIdFromBtn[0])
                  {
                     if(this._aRepliesIdFromBtn[0] >= 0)
                     {
                        this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[0]]));
                        this._lockAndWaitAnswers = true;
                     }
                     else
                     {
                        this.sysApi.sendAction(new LeaveDialogRequestAction([]));
                     }
                     this._comeBackNeeded = false;
                  }
                  else
                  {
                     this.showMore();
                  }
               }
               else if(this._currentSelectedAnswer > 0)
               {
                  if(this._aRepliesIdFromBtn[this._currentSelectedAnswer])
                  {
                     this.sysApi.sendAction(new NpcDialogReplyAction([this._aRepliesIdFromBtn[this._currentSelectedAnswer]]));
                     this._lockAndWaitAnswers = true;
                     this._comeBackNeeded = false;
                  }
                  else
                  {
                     this.showMore();
                  }
               }
               return true;
            case "closeUi":
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               return true;
            case "upArrow":
               if(this._lastAnswerIndex == -1)
               {
                  return false;
               }
               if(this._currentSelectedAnswer == -1)
               {
                  this.selectAnswer(this._lastAnswerIndex);
               }
               else
               {
                  this.unselectAnswer(this._currentSelectedAnswer);
                  answerIndex = this._currentSelectedAnswer - 1;
                  if(answerIndex < 0)
                  {
                     answerIndex = this._lastAnswerIndex;
                  }
                  this.selectAnswer(answerIndex);
               }
               return true;
               break;
            case "downArrow":
               if(this._lastAnswerIndex == -1)
               {
                  return false;
               }
               if(this._currentSelectedAnswer == -1)
               {
                  this.selectAnswer(0);
               }
               else
               {
                  this.unselectAnswer(this._currentSelectedAnswer);
                  answerIndex2 = this._currentSelectedAnswer + 1;
                  if(answerIndex2 > this._lastAnswerIndex)
                  {
                     answerIndex2 = 0;
                  }
                  this.selectAnswer(answerIndex2);
               }
               return true;
               break;
            default:
               return false;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var i:int = 0;
         if(target.name.indexOf("btn_rep") != -1)
         {
            i = int(target.name.substr(7,1));
            this.selectAnswer(i);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         var i:int = 0;
         if(target.name.indexOf("btn_rep") != -1)
         {
            i = int(target.name.substr(7,1));
            this.unselectAnswer(i);
         }
      }
      
      public function onNpcDialogQuestion(messageId:uint = 0, dialogParams:Vector.<String> = null, visibleReplies:Vector.<uint> = null) : void
      {
         var param:String = null;
         var lbl:* = undefined;
         var msg:* = undefined;
         var msgId:int = 0;
         var msgTextId:int = 0;
         var messagenpc:String = null;
         var rep:* = undefined;
         this._replies = new Vector.<uint>();
         this._moreReplies = new Vector.<uint>();
         this._lockAndWaitAnswers = false;
         var params:Array = [];
         for each(param in dialogParams)
         {
            params.push(param);
         }
         this._currentMsg = messageId;
         for each(lbl in this._aLblReplies)
         {
            lbl.text = "";
         }
         for each(msg in this._npc.dialogMessages)
         {
            msgId = msg[0];
            msgTextId = msg[1];
            if(msgId == messageId)
            {
               messagenpc = this.uiApi.decodeText(this.utilApi.getTextWithParams(msgTextId,params,"#"),this._textParams);
               this.lbl_message.text = messagenpc;
               this.lbl_message.fullSize(this.lbl_message.width);
               this.lbl_message.height = this.lbl_message.textHeight;
               for each(rep in visibleReplies)
               {
                  this._replies.push(rep);
               }
               this.repliesContainer.x = this.lbl_message.x + 20;
               this.repliesContainer.y = this.lbl_message.y + 15 + this.lbl_message.height;
               if(this._replies.length > 5)
               {
                  this.displayReplies(this._replies.slice(0,4),true);
                  this._moreReplies = this._replies.slice(4);
               }
               else
               {
                  this.displayReplies(this._replies);
               }
            }
         }
         this.ctr_content.height = this._contentHeight;
         if(this.ctr_content.height > 550)
         {
            this.ctr_content.height = 550;
         }
         this.ctr_content.finalize();
         this.refreshBackground();
      }
      
      public function onTaxCollectorDialogQuestionExtended(guildName:String, maxPods:uint, prospecting:uint, wisdom:uint, taxCollectorsCount:uint, taxCollectorAttack:int, kamas:Number, experience:int, pods:int, itemsValue:Number) : void
      {
         this.onAllianceTaxCollectorDialogQuestionExtended(guildName,maxPods,prospecting,wisdom,taxCollectorsCount,taxCollectorAttack,kamas,experience,pods,itemsValue);
      }
      
      public function onAllianceTaxCollectorDialogQuestionExtended(guildName:String, maxPods:uint, prospecting:uint, wisdom:uint, taxCollectorsCount:uint, taxCollectorAttack:int, kamas:Number, experience:int, pods:int, itemsValue:Number, alliance:BasicNamedAllianceInformations = null) : void
      {
         var msg:* = undefined;
         var msgId:int = 0;
         var msgTextId:int = 0;
         var allianceName:String = null;
         var allianceTag:String = null;
         if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.HEROIC_SERVER))
         {
            if(pods == 0)
            {
               if(alliance)
               {
                  this._currentMsg = 18063;
               }
               else
               {
                  this._currentMsg = 18064;
               }
            }
            else if(alliance)
            {
               this._currentMsg = 18065;
            }
            else
            {
               this._currentMsg = 18066;
            }
         }
         else if(alliance)
         {
            this._currentMsg = 15427;
         }
         else
         {
            this._currentMsg = 1;
         }
         for each(msg in this._npc.dialogMessages)
         {
            msgId = msg[0];
            msgTextId = msg[1];
            if(msgId == this._currentMsg)
            {
               if(this._currentMsg == 15427 || this._currentMsg == 18063 || this._currentMsg == 18065)
               {
                  allianceName = alliance.allianceName;
                  if(allianceName == "#NONAME#")
                  {
                     allianceName = this.uiApi.getText("ui.guild.noName");
                  }
                  allianceTag = alliance.allianceTag;
                  if(allianceTag == "#TAG#")
                  {
                     allianceTag = this.uiApi.getText("ui.alliance.noTag");
                  }
                  if(this._currentMsg == 15427)
                  {
                     this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount,this.utilApi.kamasToString(kamas,""),this.utilApi.kamasToString(experience,""),this.utilApi.kamasToString(pods,""),this.utilApi.kamasToString(itemsValue,""),allianceName,"[" + allianceTag + "]");
                  }
                  else if(this._currentMsg == 18065)
                  {
                     this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount,this.utilApi.kamasToString(pods,""),this.utilApi.kamasToString(itemsValue,""),allianceName,"[" + allianceTag + "]");
                  }
                  else if(this._currentMsg == 18063)
                  {
                     this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount,allianceName,"[" + allianceTag + "]");
                  }
               }
               else if(this._currentMsg == 1)
               {
                  this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount,this.utilApi.kamasToString(kamas,""),this.utilApi.kamasToString(experience,""),this.utilApi.kamasToString(pods,""),this.utilApi.kamasToString(itemsValue,""));
               }
               else if(this._currentMsg == 18066)
               {
                  this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount,this.utilApi.kamasToString(pods,""),this.utilApi.kamasToString(itemsValue,""));
               }
               else if(this._currentMsg == 18064)
               {
                  this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName,maxPods,prospecting,wisdom,taxCollectorsCount);
               }
               if(taxCollectorAttack > 0)
               {
                  this.lbl_message.text += "\n\n" + this.uiApi.processText(this.uiApi.getText("ui.social.taxCollectorWaitBeforeAttack",taxCollectorAttack),"m",taxCollectorAttack <= 1,taxCollectorAttack == 0);
               }
               else if(taxCollectorAttack < 0)
               {
                  this.lbl_message.text += "\n\n" + this.uiApi.getText("ui.social.taxCollectorNoAttack");
               }
            }
         }
         this._contentHeight = this.lbl_message.height + 10;
         this.ctr_content.height = this._contentHeight;
         if(this.ctr_content.height > 550)
         {
            this.ctr_content.height = 550;
            this.ctr_content.finalize();
         }
         this.refreshBackground();
      }
      
      public function onTaxCollectorDialogQuestionBasic(guildName:String) : void
      {
         var msg:* = undefined;
         var msgId:int = 0;
         var msgTextId:int = 0;
         this._currentMsg = 2;
         for each(msg in this._npc.dialogMessages)
         {
            msgId = msg[0];
            msgTextId = msg[1];
            if(msgId == this._currentMsg)
            {
               this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",guildName);
            }
         }
         this._contentHeight = this.lbl_message.height + 10;
         this.ctr_content.height = this._contentHeight;
         if(this.ctr_content.height > 550)
         {
            this.ctr_content.height = 550;
            this.ctr_content.finalize();
         }
         this.refreshBackground();
      }
      
      public function onAlliancePrismDialogQuestion() : void
      {
         var msg:* = undefined;
         var msgId:int = 0;
         var msgTextId:int = 0;
         var vulneStart:String = null;
         this._currentMsg = 15428;
         var subAreaId:int = this.playerApi.currentSubArea().id;
         var prism:PrismSubAreaWrapper = this.socialApi.getPrismSubAreaById(subAreaId);
         var alliance:AllianceWrapper = prism.alliance;
         if(!alliance)
         {
            alliance = this.socialApi.getAlliance();
         }
         for each(msg in this._npc.dialogMessages)
         {
            msgId = msg[0];
            msgTextId = msg[1];
            if(msgId == this._currentMsg)
            {
               vulneStart = this.timeApi.getDate(prism.nextVulnerabilityDate * 1000) + " " + this.timeApi.getClock(prism.nextVulnerabilityDate * 1000);
               this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",alliance.allianceName,this.uiApi.getText("ui.prism.state" + prism.state),vulneStart,this.utilApi.kamasToString(prism.rewardTokenCount,""));
            }
         }
         this._contentHeight = this.lbl_message.height + 10;
         this.ctr_content.height = this._contentHeight;
         if(this.ctr_content.height > 550)
         {
            this.ctr_content.height = 550;
            this.ctr_content.finalize();
         }
         this.refreshBackground();
      }
      
      public function onPortalDialogQuestion(availableUseLeft:int, durationBeforeClosure:Number) : void
      {
         var msg:* = undefined;
         var msgTextId:int = 0;
         var timeLeftBeforeClosure:String = null;
         var _loc6_:int = 0;
         var _loc7_:* = this._npc.dialogMessages;
         for each(msg in _loc7_)
         {
            msgTextId = msg[1];
            timeLeftBeforeClosure = this.timeApi.getDuration(durationBeforeClosure);
            this.lbl_message.text = this.uiApi.getTextFromKey(msgTextId,"#",availableUseLeft,timeLeftBeforeClosure);
         }
         this._contentHeight = this.lbl_message.height + 10;
         this.ctr_content.height = this._contentHeight;
         if(this.ctr_content.height > 550)
         {
            this.ctr_content.height = 550;
            this.ctr_content.finalize();
         }
         this.refreshBackground();
      }
      
      private function onLeaveDialog() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
