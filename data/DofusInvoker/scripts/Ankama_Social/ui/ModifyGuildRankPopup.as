package Ankama_Social.ui
{
   import Ankama_Common.ui.TextButtonPopup;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.events.TimerEvent;
   
   public class ModifyGuildRankPopup extends TextButtonPopup
   {
      
      private static const RANK_NAME_RESTRICTED_CHARACTERS:RegExp = /[<>{}]/g;
       
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var ctr_editRank:GraphicContainer;
      
      public var inp_rankName:Input;
      
      public var tx_rankIcon:Texture;
      
      public var ctr_editRankIcon:GraphicContainer;
      
      public var gd_rankIcons:Grid;
      
      public var ctr_icons:GraphicContainer;
      
      public var hint_rank:Texture;
      
      public var lbl_rank:Label;
      
      public var lbl_error:Label;
      
      private var _guildRankToModify:GuildRankInformation;
      
      private var _usedRankName:Vector.<String>;
      
      private var _iconIds:Vector.<uint>;
      
      private var _currentRankIconId:uint;
      
      private var _delayIconGrid:BenchmarkTimer;
      
      public function ModifyGuildRankPopup()
      {
         this._usedRankName = new Vector.<String>();
         this._iconIds = new Vector.<uint>();
         this._delayIconGrid = new BenchmarkTimer(50,1,"ModifyGuildRankPopup.delayIconGrid");
         super();
      }
      
      override public function main(params:Object) : void
      {
         this._guildRankToModify = params.guildRankInfo as GuildRankInformation;
         uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,onShortcut);
         if(this._guildRankToModify.modifiable)
         {
            uiApi.addComponentHook(this.tx_rankIcon,ComponentHookList.ON_RELEASE);
            uiApi.addComponentHook(this.ctr_editRankIcon,ComponentHookList.ON_RELEASE);
         }
         uiApi.addComponentHook(this.gd_rankIcons,ComponentHookList.ON_SELECT_ITEM);
         uiApi.addComponentHook(this.inp_rankName,ComponentHookList.ON_CHANGE);
         uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OUT);
         if(!params.hasOwnProperty("title"))
         {
            params.title = uiApi.getText("ui.guild.modifyRankTitle");
         }
         if(!params.hasOwnProperty("content"))
         {
            params.content = uiApi.getText("ui.guild.modifyRankContent");
         }
         if(!params.hasOwnProperty("buttonText"))
         {
            params.buttonText = [uiApi.getText("ui.common.save"),uiApi.getText("ui.common.cancel")];
         }
         if(!params.hasOwnProperty("buttonCallback"))
         {
            params.buttonCallback = [this.modifyRank,this.cancel];
         }
         if(!params.hasOwnProperty("onCancel"))
         {
            params.onCancel = this.cancel;
         }
         if(!params.hasOwnProperty("onEnterKey"))
         {
            params.onEnterKey = this.modifyRank;
         }
         this.ctr_editRankIcon.visible = this._guildRankToModify.modifiable;
         this.ctr_editRankIcon.disabled = !this._guildRankToModify.modifiable;
         this.tx_rankIcon.disabled = !this._guildRankToModify.modifiable;
         this.lbl_rank.text = this._guildRankToModify.name;
         this.lbl_error.text = uiApi.getText("ui.guild.errorRankExists");
         height += this.lbl_rank.anchorY + this.lbl_rank.contentHeight + this.lbl_error.anchorY + this.lbl_error.contentHeight;
         uiApi.addComponentHook(this.tx_rankIcon,ComponentHookList.ON_RELEASE);
         this.tx_rankIcon.handCursor = true;
         this.ctr_editRankIcon.handCursor = true;
         super.main(params);
         this.updateRanks();
         this._iconIds = this.socialApi.getGuildRankIconIds();
         var size:int = Math.ceil(Math.sqrt(this._iconIds.length)) * 32;
         this.ctr_icons.width = size;
         this.ctr_icons.height = size;
         this.gd_rankIcons.width = size - 10;
         this.gd_rankIcons.height = size - 10;
         this.inp_rankName.text = this._guildRankToModify.name;
         this.chooseARankIcon(this._guildRankToModify.gfxId);
         if(this._guildRankToModify.modifiable)
         {
            this._delayIconGrid.addEventListener(TimerEvent.TIMER,this.onTimerDelay);
            this._delayIconGrid.start();
         }
      }
      
      public function updateIcon(data:uint, components:*, selected:Boolean) : void
      {
         components.btn_icon.selected = false;
         if(data)
         {
            components.tx_icon.uri = this.socialApi.getGuildRankIconUriById(data);
            components.btn_icon.selected = selected;
         }
         else
         {
            components.tx_icon.uri = null;
         }
      }
      
      private function cancel() : void
      {
      }
      
      private function modifyRank() : void
      {
         this._guildRankToModify.gfxId = this._currentRankIconId;
         this._guildRankToModify.name = sysApi.trimString(this.inp_rankName.text);
         this.socialApi.modifyRank(this._guildRankToModify);
      }
      
      private function chooseARankIcon(iconId:uint) : void
      {
         this._currentRankIconId = iconId;
         if(iconId == 116 || iconId == 117)
         {
            this.tx_rankIcon.uri = uiApi.createUri(XmlConfig.getInstance().getEntry("config.gfx.path") + "guildRanks/" + iconId + ".png");
         }
         else
         {
            this.tx_rankIcon.uri = this.socialApi.getGuildRankIconUriById(iconId);
         }
         this.updateSaveButton();
      }
      
      private function updateRanks() : void
      {
         var rank:GuildRankInformation = null;
         var ranks:Vector.<GuildRankInformation> = this.socialApi.getGuildRanks();
         for each(rank in ranks)
         {
            this._usedRankName.push(this.utilApi.noAccent(rank.name).toLowerCase());
         }
      }
      
      public function onTimerDelay(e:TimerEvent) : void
      {
         this._delayIconGrid.removeEventListener(TimerEvent.TIMER,this.onTimerDelay);
         this._delayIconGrid.stop();
         this._delayIconGrid = null;
         this.gd_rankIcons.dataProvider = this._iconIds;
         this.gd_rankIcons.selectedItem = this._currentRankIconId;
         this.gd_rankIcons.updateItem(this.gd_rankIcons.selectedIndex);
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var buildIconVisible:Boolean = this.ctr_icons.visible;
         this.ctr_icons.visible = false;
         if(target == this.ctr_editRankIcon || target == this.tx_rankIcon)
         {
            if(this._guildRankToModify.modifiable)
            {
               this.gd_rankIcons.selectedItem = this._currentRankIconId;
               this.ctr_icons.visible = !buildIconVisible;
            }
            return;
         }
         super.onRelease(target);
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == GridItemSelectMethodEnum.CLICK)
         {
            if(target == this.gd_rankIcons)
            {
               if(selectMethod != GridItemSelectMethodEnum.AUTO)
               {
                  this.chooseARankIcon(target.selectedItem);
                  this.ctr_icons.visible = false;
               }
            }
         }
      }
      
      public function onChange(target:Object) : void
      {
         if(target != this.inp_rankName)
         {
            return;
         }
         if(this.inp_rankName.text !== null)
         {
            this.inp_rankName.text = this.inp_rankName.text.replace(RANK_NAME_RESTRICTED_CHARACTERS,"");
         }
         this.updateSaveButton();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target == this.hint_rank)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.guild.rankNamingRules","1","24")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      private function updateSaveButton() : void
      {
         var trimmedText:String = sysApi.trimString(this.inp_rankName.text);
         var isText:Boolean = Boolean(trimmedText);
         this.lbl_error.visible = this._usedRankName.some(function(item:String, index:int, vector:Vector.<String>):Boolean
         {
            return item == utilApi.noAccent(inp_rankName.text).toLowerCase() && item != utilApi.noAccent(_guildRankToModify.name).toLowerCase();
         });
         btn_primary.softDisabled = !isText || this.lbl_error.visible || this.inp_rankName.text.length < 1 || this.inp_rankName.text.length > 24 || this.inp_rankName.isPlaceholderActive() || this.utilApi.noAccent(this._guildRankToModify.name).toLowerCase() == this.utilApi.noAccent(trimmedText).toLowerCase() && this._currentRankIconId == this._guildRankToModify.gfxId;
      }
      
      public function closeMe() : void
      {
         uiApi.unloadUi(uiApi.me().name);
      }
   }
}
