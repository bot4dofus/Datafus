package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ColorPicker;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbolCategory;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.SocialGroupCreationResultEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GuildCreator
   {
      
      public static const CREATION:uint = 0;
      
      public static const NAME_MODIFICATION:uint = 1;
      
      public static const EMBLEM_MODIFICATION:uint = 2;
      
      public static const MODIFICATION:uint = 3;
      
      public static const EMBLEM_TAB_ICON:uint = 0;
      
      public static const EMBLEM_TAB_BACKGROUND:uint = 1;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _mode:uint = 0;
      
      private var _nCurrentTab:int = -1;
      
      private var _emblemList:Object;
      
      private var _background:Object;
      
      private var _backgroundIdx:uint;
      
      private var _backgroundColor:uint;
      
      private var _icon:EmblemWrapper;
      
      private var _iconIdx:uint;
      
      private var _iconColor:uint;
      
      private var _stickEmblem:Boolean = false;
      
      private var _iconCategories:Array;
      
      private var _currentIconCat:Object;
      
      private var _emblemsHash:String;
      
      public var tx_emblem:Texture;
      
      public var tx_icon:Texture;
      
      public var bgcbb_emblemCategory:TextureBitmap;
      
      public var inp_guildname:Input;
      
      public var gd_emblemBack:Grid;
      
      public var gd_emblemFront:Grid;
      
      public var cbb_emblemCategory:ComboBox;
      
      public var cp_colorPk:ColorPicker;
      
      public var btn_create:ButtonContainer;
      
      public var btn_background:ButtonContainer;
      
      public var btn_icon:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var tx_nameRules:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var guildNameCtr:GraphicContainer;
      
      public var emblemCreatorCtr:GraphicContainer;
      
      public var ctr_hexaColor:GraphicContainer;
      
      public var inp_hexaValue:Input;
      
      public var btn_hexaOk:ButtonContainer;
      
      public function GuildCreator()
      {
         this._iconCategories = new Array();
         super();
      }
      
      public function get mode() : uint
      {
         return this._mode;
      }
      
      public function set mode(v:uint) : void
      {
         this._mode = v;
         this.refreshUIMode();
      }
      
      public function main(... args) : void
      {
         var emblemCat:EmblemSymbolCategory = null;
         this.sysApi.addHook(SocialHookList.GuildCreationResult,this.onGuildCreationResult);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         this.uiApi.addComponentHook(this.tx_emblem,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.gd_emblemBack,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_emblemFront,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cbb_emblemCategory,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cp_colorPk,"onColorChange");
         this.uiApi.addComponentHook(this.cp_colorPk,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_create,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_background,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_icon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_nameRules,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_nameRules,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_guildname,ComponentHookList.ON_CHANGE);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.ctr_hexaColor.visible = false;
         if(args[0][0])
         {
            if(args[0][1])
            {
               this._mode = MODIFICATION;
            }
            else
            {
               this._mode = NAME_MODIFICATION;
            }
         }
         else if(args[0][1])
         {
            this._mode = EMBLEM_MODIFICATION;
         }
         else
         {
            this._mode = CREATION;
         }
         this.gd_emblemBack.visible = true;
         this.gd_emblemBack.disabled = false;
         this.gd_emblemFront.visible = false;
         this.tx_emblem.dispatchMessages = true;
         this._emblemList = this.dataApi.getEmblems();
         var namingRuleGuildName:NamingRule = this.sysApi.getCurrentServer().community.namingRuleGuildName;
         this.inp_guildname.maxChars = namingRuleGuildName.maxLength;
         var esc:Array = this.dataApi.getAllEmblemSymbolCategories();
         var allowedCategories:int = this.socialApi.getAllowedGuildEmblemSymbolCategories();
         for each(emblemCat in esc)
         {
            if(allowedCategories & Math.pow(2,emblemCat.id - 1))
            {
               this._iconCategories.push({
                  "label":emblemCat.name,
                  "value":emblemCat.id
               });
            }
         }
         this.cbb_emblemCategory.dataProvider = this._iconCategories;
         this._currentIconCat = this._iconCategories[0];
      }
      
      public function unload() : void
      {
      }
      
      public function selectBackground(item:Object, updateGrid:Boolean) : void
      {
         if(item != null)
         {
            if(updateGrid && this._nCurrentTab == EMBLEM_TAB_BACKGROUND)
            {
               this.gd_emblemBack.selectedItem = item;
            }
            this._background = item;
            this.tx_emblem.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "back/" + item.iconUri.fileName.split(".")[0] + ".swf");
         }
      }
      
      public function selectIcon(item:EmblemWrapper, updateGrid:Boolean) : void
      {
         var icon:EmblemSymbol = null;
         if(item != null)
         {
            if(updateGrid && this._nCurrentTab == EMBLEM_TAB_ICON)
            {
               this.gd_emblemFront.selectedItem = item;
            }
            this._icon = item;
            this.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "up/" + item.iconUri.fileName.split(".")[0] + ".swf");
            icon = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(this.tx_icon,this._iconColor,0);
            }
            else
            {
               this.utilApi.changeColor(this.tx_icon,this._iconColor,0,true);
            }
         }
      }
      
      public function getCurrentTab() : int
      {
         return this._nCurrentTab;
      }
      
      private function refreshUIMode() : void
      {
         this.updateLogoFromPlayerGuild();
         this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
         switch(this._mode)
         {
            case CREATION:
               this.guildNameCtr.disabled = false;
               this.emblemCreatorCtr.disabled = false;
               this.btn_background.selected = true;
               this.randomEmblem();
               break;
            case NAME_MODIFICATION:
               this.gd_emblemBack.selectedIndex = this._background.idEmblem - 1;
               this.guildNameCtr.disabled = false;
               this.emblemCreatorCtr.disabled = true;
               this.btn_create.disabled = true;
               break;
            case EMBLEM_MODIFICATION:
               this.gd_emblemBack.selectedIndex = this._background.idEmblem - 1;
               this.guildNameCtr.disabled = true;
               this.emblemCreatorCtr.disabled = false;
               this.btn_background.selected = true;
               this.btn_create.disabled = true;
               break;
            case MODIFICATION:
               this.gd_emblemBack.selectedIndex = this._background.idEmblem - 1;
               this.guildNameCtr.disabled = false;
               this.emblemCreatorCtr.disabled = false;
               this.btn_background.selected = true;
               this.btn_create.disabled = true;
         }
         this.uiApi.me().render();
      }
      
      private function updateLogoFromPlayerGuild() : void
      {
         var guild:GuildWrapper = null;
         if(this.socialApi.hasGuild())
         {
            guild = this.socialApi.getGuild();
            if(!this.socialApi.isGuildNameInvalid())
            {
               this.inp_guildname.text = guild.guildName;
            }
            this._background = guild.backEmblem;
            this.tx_emblem.uri = this._background.fullSizeIconUri;
            this._backgroundColor = this._background.color;
            this._icon = guild.upEmblem;
            this.tx_icon.uri = this._icon.fullSizeIconUri;
            this._iconColor = this._icon.color;
            this.setIconColor(this._iconColor);
         }
      }
      
      private function randomEmblem() : void
      {
         var rnd:int = 0;
         rnd = Math.floor(Math.random() * this._emblemList[EMBLEM_TAB_BACKGROUND].length);
         this.selectBackground(this._emblemList[EMBLEM_TAB_BACKGROUND][rnd],false);
         this.setBackgroundColor(Math.random() * 16777215);
         rnd = Math.floor(Math.random() * this._emblemList[EMBLEM_TAB_ICON].length);
         this.selectIcon(this._emblemList[EMBLEM_TAB_ICON][rnd],false);
         this.setIconColor(Math.random() * 16777215);
      }
      
      private function openSelectedTab(tab:int) : void
      {
         var cat:Object = null;
         if(this._nCurrentTab == tab)
         {
            return;
         }
         this._nCurrentTab = tab;
         this._stickEmblem = true;
         switch(tab)
         {
            case EMBLEM_TAB_ICON:
               if(this.gd_emblemFront.dataProvider.length == 0)
               {
                  if(this._icon)
                  {
                     for each(cat in this._iconCategories)
                     {
                        if(this._icon.category == cat.value)
                        {
                           this._currentIconCat = cat;
                           this.cbb_emblemCategory.selectedItem = this._currentIconCat;
                        }
                     }
                  }
                  this.updateIconGrid();
                  this.gd_emblemFront.selectedItem = this._icon;
               }
               this.gd_emblemBack.visible = false;
               this.gd_emblemFront.visible = true;
               this.cbb_emblemCategory.visible = this.bgcbb_emblemCategory.visible = true;
               this.cp_colorPk.color = this._iconColor;
               break;
            case EMBLEM_TAB_BACKGROUND:
               if(this.gd_emblemBack.dataProvider.length == 0)
               {
                  this.gd_emblemBack.dataProvider = this._emblemList[EMBLEM_TAB_BACKGROUND];
                  this.gd_emblemBack.selectedItem = this._background;
               }
               this.gd_emblemBack.visible = true;
               this.gd_emblemFront.visible = false;
               this.cbb_emblemCategory.visible = this.bgcbb_emblemCategory.visible = false;
               this.cp_colorPk.color = this._backgroundColor;
         }
         this._stickEmblem = false;
      }
      
      private function setBackgroundColor(color:Number) : void
      {
         this._backgroundColor = color;
         if(this.tx_emblem && this.tx_emblem.uri && this.tx_emblem.child && this.tx_emblem.child.hasOwnProperty("back") && Object(this.tx_emblem.child).back)
         {
            this.utilApi.changeColor(this.tx_emblem.getChildByName("back"),this._backgroundColor,1);
         }
      }
      
      private function setIconColor(color:Number) : void
      {
         var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(this._icon.idEmblem);
         this._iconColor = color;
         if(icon.colorizable)
         {
            this.utilApi.changeColor(this.tx_icon,this._iconColor,0);
         }
         else
         {
            this.utilApi.changeColor(this.tx_icon,this._iconColor,0,true);
         }
      }
      
      private function _unloadGuildCreation() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function updateIconGrid() : void
      {
         var initialIconIndex:int = 0;
         var emblem:EmblemWrapper = null;
         var DP:Array = [];
         var hash:String = "";
         for each(emblem in this._emblemList[EMBLEM_TAB_ICON])
         {
            if(emblem.category == this._currentIconCat.value || this._currentIconCat.value == uint.MAX_VALUE)
            {
               DP.push(emblem);
               hash += emblem.idEmblem + "-";
               if(emblem.idEmblem == this._icon.idEmblem)
               {
                  initialIconIndex = DP.length - 1;
               }
            }
         }
         if(this._emblemsHash != hash)
         {
            this.gd_emblemFront.dataProvider = DP;
            this.gd_emblemFront.selectedIndex = initialIconIndex;
            this._emblemsHash = hash;
         }
      }
      
      private function checkModifications() : void
      {
         var guild:GuildWrapper = null;
         if(this.socialApi.hasGuild())
         {
            guild = this.socialApi.getGuild();
            if(this.inp_guildname.text == guild.guildName && this._background.idEmblem == guild.backEmblem.idEmblem && this._backgroundColor == guild.backEmblem.color && this._icon.idEmblem == guild.upEmblem.idEmblem && this._iconColor == guild.upEmblem.color)
            {
               this.btn_create.disabled = true;
            }
            else
            {
               this.btn_create.disabled = false;
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var color:uint = 0;
         var namingRuleGuildName:NamingRule = null;
         var position:int = 0;
         switch(target)
         {
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogAction([]));
               this._unloadGuildCreation();
               break;
            case this.btn_background:
               this.openSelectedTab(EMBLEM_TAB_BACKGROUND);
               break;
            case this.btn_icon:
               this.openSelectedTab(EMBLEM_TAB_ICON);
               this.setBackgroundColor(this._backgroundColor);
               break;
            case this.btn_hexaOk:
               color = int(Number("0x" + this.inp_hexaValue.text));
               this.onColorChange({},color);
               this.cp_colorPk.color = color;
               break;
            case this.cp_colorPk:
               if(this.uiApi.keyIsDown(16))
               {
                  this.inp_hexaValue.text = this.cp_colorPk.color.toString(16);
                  this.ctr_hexaColor.visible = true;
                  this.inp_hexaValue.focus();
                  position = this.inp_hexaValue.text.length;
                  this.inp_hexaValue.setSelection(position,position);
               }
               break;
            case this.btn_create:
               namingRuleGuildName = this.sysApi.getCurrentServer().community.namingRuleGuildName;
               if(this._mode != EMBLEM_MODIFICATION && (this.inp_guildname.text.length < namingRuleGuildName.minLength || this.inp_guildname.text.length > namingRuleGuildName.maxLength))
               {
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.guild.invalidName"),[this.uiApi.getText("ui.common.ok")]);
               }
               else if(this._mode == CREATION)
               {
                  this.sysApi.sendAction(new GuildCreationValidAction([this.inp_guildname.text,this._icon.idEmblem,this._iconColor,this._background.idEmblem,this._backgroundColor]));
               }
               else if(this._mode == NAME_MODIFICATION)
               {
                  this.sysApi.sendAction(new GuildModificationNameValidAction([this.inp_guildname.text]));
               }
               else if(this._mode == EMBLEM_MODIFICATION)
               {
                  this.sysApi.sendAction(new GuildModificationEmblemValidAction([this._icon.idEmblem,this._iconColor,this._background.idEmblem,this._backgroundColor]));
               }
               else if(this._mode == MODIFICATION)
               {
                  this.sysApi.sendAction(new GuildModificationValidAction([this.inp_guildname.text,this._icon.idEmblem,this._iconColor,this._background.idEmblem,this._backgroundColor]));
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.social.nameRules")),target,false,"standard",0,0,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         if(target == this.inp_guildname)
         {
            this.checkModifications();
         }
      }
      
      public function onColorChange(target:Object, fixedColor:int = -1) : void
      {
         var color:Number = NaN;
         if(!this.ctr_hexaColor.visible)
         {
            color = this.cp_colorPk.color;
         }
         else
         {
            color = fixedColor;
            this.ctr_hexaColor.visible = false;
         }
         switch(this._nCurrentTab)
         {
            case 0:
               if(!this._stickEmblem)
               {
                  this.setIconColor(color);
               }
               break;
            case 1:
               if(!this._stickEmblem)
               {
                  this.setBackgroundColor(color);
               }
         }
         this.checkModifications();
      }
      
      public function onGuildCreationResult(result:uint) : void
      {
         switch(result)
         {
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_OK:
               this._unloadGuildCreation();
               break;
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_ALREADY_EXISTS:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.guild.AlreadyUseName"),[this.uiApi.getText("ui.common.ok")]);
               break;
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_NAME_INVALID:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.guild.invalidName"),[this.uiApi.getText("ui.common.ok")]);
               break;
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_EMBLEM_ALREADY_EXISTS:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.guild.AlreadyUseEmblem"),[this.uiApi.getText("ui.common.ok")]);
               break;
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_CANCEL:
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_LEAVE:
               break;
            case SocialGroupCreationResultEnum.SOCIAL_GROUP_CREATE_ERROR_REQUIREMENT_UNMET:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.guild.requirementUnmet"),[this.uiApi.getText("ui.common.ok")]);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.gd_emblemBack:
               if(isNewSelection && !this._stickEmblem && selectMethod != SelectMethodEnum.AUTO)
               {
                  this.selectBackground((target as Grid).selectedItem,false);
                  this.checkModifications();
               }
               break;
            case this.gd_emblemFront:
               if(!this._stickEmblem && selectMethod != SelectMethodEnum.AUTO && (isNewSelection || this.gd_emblemFront.dataProvider.length == 1))
               {
                  this.selectIcon((target as Grid).selectedItem as EmblemWrapper,false);
                  this.checkModifications();
               }
               break;
            case this.cbb_emblemCategory:
               if(isNewSelection)
               {
                  this._currentIconCat = this._iconCategories[this.cbb_emblemCategory.selectedIndex];
                  switch(selectMethod)
                  {
                     case 0:
                     case 3:
                     case 4:
                     case 8:
                        this._stickEmblem = true;
                        this.updateIconGrid();
                        this._stickEmblem = false;
                  }
                  break;
               }
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_emblem:
               this.utilApi.changeColor(target.getChildByName("back"),this._backgroundColor,1);
         }
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(name == "guildCreator")
         {
            if(this.socialApi.isGuildNameInvalid())
            {
               this._mode = NAME_MODIFICATION;
            }
            this.refreshUIMode();
         }
      }
      
      public function onLeaveDialog() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var color:uint = 0;
         switch(s)
         {
            case "validUi":
               if(this.ctr_hexaColor.visible)
               {
                  color = int(Number("0x" + this.inp_hexaValue.text));
                  this.onColorChange({},color);
                  this.cp_colorPk.color = color;
               }
               return true;
            case "closeUi":
               if(this.ctr_hexaColor.visible)
               {
                  this.ctr_hexaColor.visible = false;
               }
               else
               {
                  this.sysApi.sendAction(new LeaveDialogAction([]));
                  this._unloadGuildCreation();
               }
               return true;
            default:
               return false;
         }
      }
   }
}
