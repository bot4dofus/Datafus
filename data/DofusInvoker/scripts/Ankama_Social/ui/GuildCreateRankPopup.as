package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.GuildRankNameSuggestion;
   import com.ankamagames.dofus.logic.game.common.actions.guild.CreateGuildRankRequestAction;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class GuildCreateRankPopup
   {
      
      private static const RANK_NAME_RESTRICTED_CHARACTERS:RegExp = /[<>{}]/g;
       
      
      public var lbl_rankNameText:Label;
      
      public var lbl_error:Label;
      
      public var lbl_rankRightsText:Label;
      
      public var cb_rankName:ComboBox;
      
      public var cb_rankRights:ComboBox;
      
      public var inp_rankName:Input;
      
      public var hint_rank:Texture;
      
      public var tx_rankIcon:Texture;
      
      public var ctr_editRankIcon:GraphicContainer;
      
      public var ctr_icons:GraphicContainer;
      
      public var gd_rankIcons:Grid;
      
      public var btn_primary:ButtonContainer;
      
      public var btn_lbl_btn_primary:Label;
      
      public var lbl_btn_secondary:Label;
      
      public var btn_texture_btn_primary:TextureBitmap;
      
      public var popup:GraphicContainer;
      
      public var lbl_title_popup:Label;
      
      public var btn_close_popup:ButtonContainer;
      
      private var _ranks:Vector.<GuildRankInformation>;
      
      private var _usedRankName:Vector.<String>;
      
      private var _usedIcons:Vector.<uint>;
      
      private var _rankNameSuggestions:Array;
      
      private var _currentRankIconId:uint;
      
      private var _iconIds:Vector.<uint>;
      
      private var _delayIconGrid:BenchmarkTimer;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public function GuildCreateRankPopup()
      {
         this._usedRankName = new Vector.<String>();
         this._usedIcons = new Vector.<uint>();
         this._rankNameSuggestions = [];
         this._iconIds = new Vector.<uint>();
         this._delayIconGrid = new BenchmarkTimer(50,1,"GuildCreateRank.delayIconGrid");
         super();
      }
      
      public function main(params:Object) : void
      {
         this.lbl_title_popup.text = this.uiApi.getText("ui.guild.createRank");
         this.lbl_rankNameText.text = this.uiApi.getText("ui.guild.chooseRankName");
         this.lbl_error.text = this.uiApi.getText("ui.guild.errorRankExists");
         this.lbl_rankRightsText.text = this.uiApi.getText("ui.guild.chooseParentRank");
         this.btn_lbl_btn_primary.text = this.uiApi.getText("ui.charcrea.create");
         this.lbl_btn_secondary.text = this.uiApi.getText("ui.common.cancel");
         this.lbl_btn_secondary.fullWidth();
         this.lbl_btn_secondary.handCursor = true;
         this.uiApi.addComponentHook(this.lbl_btn_secondary,ComponentHookList.ON_RELEASE);
         this.btn_lbl_btn_primary.fullWidthAndHeight();
         this.btn_primary.width = this.btn_lbl_btn_primary.width + Number(this.uiApi.me().getConstant("primary_button_margin")) * 2;
         this.btn_texture_btn_primary.width = this.btn_primary.width;
         this.btn_lbl_btn_primary.width = this.btn_primary.width;
         this.lbl_rankNameText.fullWidthAndHeight(0,20);
         this.lbl_error.fullWidthAndHeight(0,20);
         this.lbl_rankRightsText.fullWidthAndHeight(0,20);
         var height:Number = this.lbl_error.height + this.lbl_rankRightsText.height + this.tx_rankIcon.height + this.cb_rankRights.height + this.lbl_rankNameText.y + this.lbl_rankNameText.height - this.lbl_title_popup.y + Number(this.uiApi.me().getConstant("bottom_margin"));
         this.popup.height = height;
         this.uiApi.addComponentHook(this.tx_rankIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_editRankIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_rankIcons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_rankName,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_rankRights,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_rankName,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OUT);
         this.tx_rankIcon.handCursor = true;
         this.ctr_editRankIcon.handCursor = true;
         this._rankNameSuggestions = this.dataApi.getGuildRankNameSuggestions();
         this._rankNameSuggestions = this._rankNameSuggestions.map(function(item:GuildRankNameSuggestion, index:int, array:Array):String
         {
            return uiApi.getText("ui." + item.uiKey);
         });
         this._rankNameSuggestions = this._rankNameSuggestions.sort(this.sortByRankName);
         this.updateRanks();
         this.inp_rankName.placeholderText = this.uiApi.getText("ui.guild.customRank");
         this.cb_rankRights.dataProvider = this._ranks;
         this.cb_rankRights.selectedIndex = this.cb_rankRights.dataProvider.length - 1;
         this.cb_rankName.dataProvider = this._rankNameSuggestions;
         this.cb_rankName.container.visible = false;
         this._iconIds = this.socialApi.getGuildRankIconIds();
         var size:int = Math.ceil(Math.sqrt(this._iconIds.length)) * 32;
         this.ctr_icons.width = size;
         this.ctr_icons.height = size;
         this.gd_rankIcons.width = size - 10;
         this.gd_rankIcons.height = size - 10;
         this._delayIconGrid.addEventListener(TimerEvent.TIMER,this.onTimerDelay);
         this._delayIconGrid.start();
         this.chooseARankIcon(this.getUnusedIcon());
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
      
      public function updateRankRightsLine(data:GuildRankInformation, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.lbl_cb_rankName.text = data.name;
            components.lbl_cb_rankName.verticalAlign = "center";
         }
      }
      
      public function getUnusedIcon() : uint
      {
         var possibleIcons:Vector.<uint> = new Vector.<uint>();
         for(var i:int = 0; i < this._iconIds.length; i++)
         {
            if(this._usedIcons.indexOf(this._iconIds[i]) == -1)
            {
               possibleIcons.push(this._iconIds[i]);
            }
         }
         return possibleIcons[Math.floor(Math.random() * possibleIcons.length)];
      }
      
      private function updateRanks() : void
      {
         var rank:GuildRankInformation = null;
         var indexinSuggestion:int = 0;
         this._ranks = this.socialApi.getGuildRanks();
         for each(rank in this._ranks)
         {
            this._usedRankName.push(this.utilApi.noAccent(rank.name).toLowerCase());
            this._usedIcons.push(rank.gfxId);
            indexinSuggestion = -1;
            this._rankNameSuggestions.some(function(item:String, index:int, array:Array):Boolean
            {
               if(utilApi.noAccent(rank.name).toLowerCase() == utilApi.noAccent(item).toLowerCase())
               {
                  indexinSuggestion = index;
                  return true;
               }
               return false;
            });
            if(indexinSuggestion != -1)
            {
               this._rankNameSuggestions.removeAt(indexinSuggestion);
            }
         }
      }
      
      private function chooseARankIcon(iconId:uint) : void
      {
         this._currentRankIconId = iconId;
         this.tx_rankIcon.uri = this.socialApi.getGuildRankIconUriById(iconId);
         this.updateCreateButton();
      }
      
      private function cancel() : void
      {
         this.closeMe();
      }
      
      private function create() : void
      {
         if(this.btn_primary.softDisabled)
         {
            return;
         }
         var parentRankId:uint = (this.cb_rankRights.selectedItem as GuildRankInformation).id;
         this.sysApi.sendAction(CreateGuildRankRequestAction.create(parentRankId,this._currentRankIconId,this.sysApi.trimString(this.inp_rankName.text)));
         this.closeMe();
      }
      
      private function sortByRankName(rankNameA:String, rankNameB:String) : int
      {
         var firstValue:String = this.utilApi.noAccent(rankNameA).toUpperCase();
         var secondValue:String = this.utilApi.noAccent(rankNameB).toUpperCase();
         if(firstValue > secondValue)
         {
            return 1;
         }
         if(firstValue < secondValue)
         {
            return -1;
         }
         return 0;
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == GridItemSelectMethodEnum.CLICK)
         {
            if(target == this.cb_rankName)
            {
               this.inp_rankName.focus();
               this.inp_rankName.text = target.selectedItem;
            }
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
      
      public function onRelease(target:GraphicContainer) : void
      {
         var buildIconVisible:Boolean = this.ctr_icons.visible;
         this.ctr_icons.visible = false;
         if(target == this.ctr_editRankIcon || target == this.tx_rankIcon)
         {
            this.gd_rankIcons.selectedItem = this._currentRankIconId;
            this.ctr_icons.visible = !buildIconVisible;
         }
         else if(target == this.btn_primary)
         {
            this.create();
         }
         else if(target == this.lbl_btn_secondary || target == this.btn_close_popup)
         {
            this.cancel();
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
         this.updateCreateButton();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target == this.hint_rank)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.guild.rankNamingRules","1","24")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function updateCreateButton() : void
      {
         var isText:Boolean = Boolean(this.sysApi.trimString(this.inp_rankName.text));
         this.lbl_error.visible = this._usedRankName.some(function(item:String, index:int, vector:Vector.<String>):Boolean
         {
            return item == utilApi.noAccent(inp_rankName.text).toLowerCase();
         });
         this.btn_primary.softDisabled = !isText || this.lbl_error.visible || this.inp_rankName.text.length < 1 || this.inp_rankName.text.length > 24 || this.inp_rankName.isPlaceholderActive();
      }
      
      public function closeMe() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
