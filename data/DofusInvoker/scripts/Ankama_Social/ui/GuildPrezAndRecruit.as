package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MultipleComboBox;
   import com.ankamagames.berilia.components.TextAreaInput;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.datacenter.guild.GuildTag;
   import com.ankamagames.dofus.datacenter.servers.ServerLang;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildRecruitmentDataWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetInformationsAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.SendGuildRecruitmentDataAction;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildInformationsTypeEnum;
   import com.ankamagames.dofus.network.enums.GuildRecruitmentTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GuildPrezAndRecruit
   {
      
      private static const TOOLTIP_UI_NAME:String = "GuildPrezAndRecruitTooltip";
      
      private static const MAX_PRES_TITLE_LENGTH:uint = 70;
      
      private static const MAX_AD_LENGTH:uint = 270;
      
      private static const MIN_LEVEL_MIN:uint = 1;
      
      private static const MIN_LEVEL_MAX:uint = 200;
      
      private static const MIN_ACHIEVEMENT_POINTS_MIN:uint = 0;
      
      private static const TAG_TYPE_GOAL:int = 1;
      
      private static const TAG_TYPE_ATMOSPHERE:int = 2;
      
      private static const TAG_TYPE_LOGIN_HABITS:int = 3;
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_rulesWarning:GraphicContainer;
      
      public var ctr_rulesLink:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_save:ButtonContainer;
      
      public var btn_isMinLevelRequired:ButtonContainer;
      
      public var btn_areMinAchievementPointsRequired:ButtonContainer;
      
      public var cbx_recruitmentMode:ComboBox;
      
      public var mcbx_languages:MultipleComboBox;
      
      public var mcbx_goal:MultipleComboBox;
      
      public var mcbx_atmosphere:MultipleComboBox;
      
      public var mcbx_loginHabits:MultipleComboBox;
      
      public var lbl_guildPresTitle:Label;
      
      public var lbl_guildAd:Label;
      
      public var lbl_minLevel:Label;
      
      public var lbl_minAchievementPoints:Label;
      
      public var lbl_rulesWarning:Label;
      
      public var lbl_rulesLink:Label;
      
      public var btn_label_btn_isMinLevelRequired:Label;
      
      public var btn_label_btn_areMinAchievementPointsRequired:Label;
      
      public var inp_guildAdInput:TextAreaInput;
      
      public var inp_guildPresTitleInput:Input;
      
      public var inp_minLevelInput:Input;
      
      public var inp_minAchievementPointsInput:Input;
      
      public var tx_guildLogo:Texture;
      
      public var tx_guildLogoBackground:Texture;
      
      public var tx_saveHint:Texture;
      
      public var tx_recruitmentWarning:Texture;
      
      private var _texturesPath:String;
      
      private var _recruitmentData:GuildRecruitmentDataWrapper;
      
      private var _totalAchievementPoints:Number = 0;
      
      public function GuildPrezAndRecruit()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.mcbx_languages,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mcbx_languages,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.mcbx_goal,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mcbx_goal,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.mcbx_atmosphere,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mcbx_atmosphere,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.mcbx_loginHabits,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.mcbx_loginHabits,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_guildPresTitleInput,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_guildAdInput,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_minLevelInput,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.inp_minAchievementPointsInput,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_isMinLevelRequired,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_areMinAchievementPointsRequired,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_guildLogoBackground,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_guildLogo,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.ctr_rulesLink,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(SocialHookList.GuildRecruitmentDataReceived,this.onRecruitmentData);
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this._totalAchievementPoints = this.dataApi.getTotalAchievementPoints();
         this._texturesPath = this.uiApi.me().getConstant("texture");
         this.setLanguageChoices();
         this.setRecruitmentModeChoices();
         this.lbl_minLevel.fullWidth();
         this.lbl_minAchievementPoints.fullWidth();
         this.lbl_rulesWarning.fullWidth();
         this.lbl_rulesLink.fullWidth();
         this.btn_label_btn_isMinLevelRequired.fullWidth();
         this.btn_label_btn_areMinAchievementPointsRequired.fullWidth();
         this.mcbx_goal.dataProvider = this.getTagChoices(TAG_TYPE_GOAL);
         this.mcbx_atmosphere.dataProvider = this.getTagChoices(TAG_TYPE_ATMOSPHERE);
         this.mcbx_loginHabits.dataProvider = this.getTagChoices(TAG_TYPE_LOGIN_HABITS);
         this.updateUiFromPresTitle();
         this.updateUiFromAd();
         this.tx_guildLogoBackground.dispatchMessages = true;
         this.tx_guildLogo.dispatchMessages = true;
         var guildInfo:GuildWrapper = this.socialApi.getGuild();
         this.tx_guildLogo.uri = this.uiApi.createUri(guildInfo.upEmblem.fullSizeIconUri.toString());
         this.tx_guildLogoBackground.uri = this.uiApi.createUri(guildInfo.backEmblem.fullSizeIconUri.toString());
         this.setRecruitmentData(params !== null && params.recruitmentData !== null ? params.recruitmentData : null);
         this.sysApi.sendAction(new GuildGetInformationsAction([GuildInformationsTypeEnum.INFO_RECRUITMENT]));
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function updateUiFromPresTitle() : void
      {
         var hexColor:Number = NaN;
         var currentLength:int = this.inp_guildPresTitleInput.text.length;
         var delta:int = MAX_PRES_TITLE_LENGTH - currentLength;
         var deltaLabel:* = delta.toString();
         if(delta < 0)
         {
            hexColor = Number(this.sysApi.getConfigEntry("colors.tooltip.text.red"));
            deltaLabel = "<font color=\'" + "#" + hexColor.toString(16) + "\'>" + deltaLabel + "</font>";
         }
         this.lbl_guildPresTitle.text = this.uiApi.getText("ui.guild.recruitment.titleHeader") + " (" + deltaLabel + ")";
         this.updateSaveButton();
      }
      
      private function updateUiFromAd() : void
      {
         var hexColor:Number = NaN;
         var currentLength:int = this.inp_guildAdInput.text.length;
         var delta:int = MAX_AD_LENGTH - currentLength;
         var deltaLabel:* = delta.toString();
         if(delta < 0)
         {
            hexColor = Number(this.sysApi.getConfigEntry("colors.tooltip.text.red"));
            deltaLabel = "<font color=\'" + "#" + hexColor.toString(16) + "\'>" + deltaLabel + "</font>";
         }
         this.lbl_guildAd.text = this.uiApi.getText("ui.guild.recruitment.adHeader") + " (" + deltaLabel + ")";
         this.updateSaveButton();
      }
      
      private function updateSaveButton() : void
      {
         var isSaveDisabled:* = !this.isSavePossible();
         if(this.btn_save.softDisabled === isSaveDisabled)
         {
            return;
         }
         this.btn_save.softDisabled = isSaveDisabled;
         if(isSaveDisabled)
         {
            this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.uiApi.removeComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function updateUiFromMinLevel() : void
      {
         var minLevel:Number = !!this.inp_minLevelInput.text ? Number(Number(this.inp_minLevelInput.text)) : Number(Number.NaN);
         if(isNaN(minLevel) || minLevel < MIN_LEVEL_MIN)
         {
            minLevel = MIN_LEVEL_MIN;
         }
         else
         {
            if(minLevel <= MIN_LEVEL_MAX)
            {
               return;
            }
            minLevel = MIN_LEVEL_MAX;
         }
         this.inp_minLevelInput.text = minLevel.toString();
      }
      
      private function updateUiFromMinAchievementPoints() : void
      {
         var minAchievementPoints:Number = !!this.inp_minAchievementPointsInput.text ? Number(Number(this.inp_minAchievementPointsInput.text)) : Number(Number.NaN);
         if(isNaN(minAchievementPoints) || minAchievementPoints < MIN_ACHIEVEMENT_POINTS_MIN)
         {
            minAchievementPoints = MIN_ACHIEVEMENT_POINTS_MIN;
         }
         else
         {
            if(minAchievementPoints <= this._totalAchievementPoints)
            {
               return;
            }
            minAchievementPoints = this._totalAchievementPoints;
         }
         this.inp_minAchievementPointsInput.text = minAchievementPoints.toString();
      }
      
      private function isSavePossible() : Boolean
      {
         return MAX_PRES_TITLE_LENGTH - this.inp_guildPresTitleInput.text.length >= 0 && MAX_AD_LENGTH - this.inp_guildAdInput.text.length >= 0;
      }
      
      private function setLanguageChoices() : void
      {
         var language:ServerLang = null;
         var languageObjs:Array = [];
         var languages:Array = ServerLang.getServerLangs();
         for each(language in languages)
         {
            if(language !== null)
            {
               languageObjs.push({
                  "order":language.langCode,
                  "typeId":language.langCode,
                  "languageId":language.id,
                  "label":language.name,
                  "icon":this.uiApi.createUri(this._texturesPath + "/languages/language_" + language.id + ".png")
               });
            }
         }
         languageObjs.sortOn("typeId",Array.CASEINSENSITIVE);
         this.mcbx_languages.dataProvider = languageObjs;
      }
      
      private function setRecruitmentModeChoices() : void
      {
         this.cbx_recruitmentMode.dataProvider = new <Object>[{
            "typeId":GuildRecruitmentTypeEnum.DISABLED,
            "label":this.uiApi.getText("ui.guild.recruitment.blocked"),
            "icon":this.uiApi.createUri(this._texturesPath + "icon_false.png")
         },{
            "typeId":GuildRecruitmentTypeEnum.AUTOMATIC,
            "label":this.uiApi.getText("ui.guild.recruitment.automatic"),
            "icon":this.uiApi.createUri(this._texturesPath + "icon_check.png")
         },{
            "typeId":GuildRecruitmentTypeEnum.MANUAL,
            "label":this.uiApi.getText("ui.guild.recruitment.manual"),
            "icon":this.uiApi.createUri(this._texturesPath + "icon_check.png")
         }];
      }
      
      private function getTagChoices(tagId:int) : Array
      {
         var tag:GuildTag = null;
         var tags:Vector.<GuildTag> = this.dataApi.getGuildTagsFromGuildTagId(tagId);
         var tagObjs:Array = [];
         for each(tag in tags)
         {
            tagObjs.push({
               "typeId":tag.id,
               "label":tag.name,
               "order":tag.order
            });
         }
         tagObjs.sortOn("order",Array.NUMERIC);
         return tagObjs;
      }
      
      private function loadSelectedLanguages() : void
      {
         var languageId:uint = 0;
         var language:ServerLang = null;
         if(this._recruitmentData === null)
         {
            this.mcbx_languages.value = [];
            return;
         }
         var selectedLanguages:Vector.<uint> = this._recruitmentData.selectedLanguages;
         var languageObjs:Array = [];
         for each(languageId in selectedLanguages)
         {
            language = this.dataApi.getServerLang(languageId);
            if(language !== null)
            {
               languageObjs.push({
                  "order":language.langCode,
                  "typeId":language.langCode,
                  "languageId":language.id,
                  "label":language.name,
                  "icon":this.uiApi.createUri(this._texturesPath + "/languages/language_" + language.id + ".png")
               });
            }
         }
         this.mcbx_languages.value = languageObjs;
      }
      
      private function loadSelectedTags() : void
      {
         var tagId:uint = 0;
         var guildTag:GuildTag = null;
         var tagObj:Object = null;
         if(this._recruitmentData === null)
         {
            this.mcbx_goal.value = [];
            this.mcbx_atmosphere.value = [];
            this.mcbx_loginHabits.value = [];
            return;
         }
         var selectedTags:Vector.<uint> = this._recruitmentData.selectedCriteria;
         var selectedGoalTags:Array = [];
         var selectedAtmosphereTags:Array = [];
         var selectedLoginHabitsTags:Array = [];
         for each(tagId in selectedTags)
         {
            guildTag = GuildTag.getGuildTagById(tagId);
            if(guildTag === null)
            {
               continue;
            }
            tagObj = {
               "typeId":guildTag.id,
               "label":guildTag.name,
               "order":guildTag.order
            };
            switch(guildTag.typeId)
            {
               case TAG_TYPE_GOAL:
                  selectedGoalTags.push(tagObj);
                  break;
               case TAG_TYPE_ATMOSPHERE:
                  selectedAtmosphereTags.push(tagObj);
                  break;
               case TAG_TYPE_LOGIN_HABITS:
                  selectedLoginHabitsTags.push(tagObj);
                  break;
            }
         }
         this.mcbx_goal.value = selectedGoalTags;
         this.mcbx_atmosphere.value = selectedAtmosphereTags;
         this.mcbx_loginHabits.value = selectedLoginHabitsTags;
      }
      
      private function loadSelectedRecruitmentMode() : void
      {
         if(this._recruitmentData === null)
         {
            this.mcbx_goal.selectedIndex = 1;
            this.tx_recruitmentWarning.visible = false;
            this.uiApi.removeComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.removeComponentHook(this.cbx_recruitmentMode,ComponentHookList.ON_CHANGE);
            return;
         }
         this.cbx_recruitmentMode.selectedIndex = this._recruitmentData.recruitmentType;
         if(this._recruitmentData.recruitmentType === GuildRecruitmentTypeEnum.AUTOMATIC)
         {
            this.uiApi.addComponentHook(this.cbx_recruitmentMode,ComponentHookList.ON_CHANGE);
         }
         else
         {
            this.uiApi.removeComponentHook(this.cbx_recruitmentMode,ComponentHookList.ON_CHANGE);
         }
         if(this._recruitmentData.wasRecruitmentAutoLocked)
         {
            this.tx_recruitmentWarning.visible = true;
            this.uiApi.addComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.tx_recruitmentWarning.visible = false;
            this.uiApi.removeComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.tx_recruitmentWarning,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function setRecruitmentData(recruitmentData:GuildRecruitmentDataWrapper) : void
      {
         var areRequiredCheckboxesVisible:* = false;
         this._recruitmentData = recruitmentData;
         if(this._recruitmentData !== null)
         {
            this.ctr_rulesWarning.visible = this._recruitmentData.isInvalidated;
            this.inp_guildPresTitleInput.text = this._recruitmentData.recruitmentTitle;
            this.inp_guildAdInput.text = this._recruitmentData.recruitmentText;
            this.inp_minLevelInput.text = this._recruitmentData.minLevel.toString();
            this.inp_minAchievementPointsInput.text = this._recruitmentData.minAchievementPoints.toString();
            this.btn_isMinLevelRequired.selected = this._recruitmentData.isMinLevelRequired;
            this.btn_areMinAchievementPointsRequired.selected = this._recruitmentData.areMinAchievementPointsRequired;
            this.btn_isMinLevelRequired.visible = false;
            this.btn_isMinLevelRequired.visible = false;
         }
         else
         {
            this.ctr_rulesWarning.visible = false;
            this.inp_guildPresTitleInput.text = "";
            this.inp_guildAdInput.text = "";
            this.inp_minLevelInput.text = "";
            this.inp_minAchievementPointsInput.text = "";
            this.btn_isMinLevelRequired.selected = false;
            this.btn_areMinAchievementPointsRequired.selected = false;
            areRequiredCheckboxesVisible = this.cbx_recruitmentMode.value === GuildRecruitmentTypeEnum.AUTOMATIC;
            this.btn_isMinLevelRequired.visible = areRequiredCheckboxesVisible;
            this.btn_areMinAchievementPointsRequired.visible = areRequiredCheckboxesVisible;
         }
         this.loadSelectedLanguages();
         this.loadSelectedTags();
         this.loadSelectedRecruitmentMode();
         this.setSaveHint();
      }
      
      private function setSaveHint() : void
      {
         if(this._recruitmentData == null || !this._recruitmentData.lastEditorName || this._recruitmentData.lastEditDate === 0)
         {
            this.uiApi.removeComponentHook(this.tx_saveHint,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.tx_saveHint,ComponentHookList.ON_ROLL_OUT);
            this.tx_saveHint.visible = false;
            return;
         }
         this.uiApi.addComponentHook(this.tx_saveHint,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_saveHint,ComponentHookList.ON_ROLL_OUT);
         this.tx_saveHint.visible = true;
      }
      
      private function sendRecruitmentSettings() : void
      {
         var value:Object = null;
         var guildId:uint = this._recruitmentData !== null ? uint(this._recruitmentData.guildId) : uint(this.socialApi.getGuild().guildId);
         this._recruitmentData = new GuildRecruitmentDataWrapper(guildId);
         this._recruitmentData.recruitmentTitle = this.inp_guildPresTitleInput.text;
         this._recruitmentData.recruitmentText = this.inp_guildAdInput.text;
         for each(value in this.mcbx_languages.value)
         {
            this._recruitmentData.selectedLanguages.push(value.languageId);
         }
         for each(value in this.mcbx_goal.value)
         {
            this._recruitmentData.selectedCriteria.push(value.typeId);
         }
         for each(value in this.mcbx_atmosphere.value)
         {
            this._recruitmentData.selectedCriteria.push(value.typeId);
         }
         for each(value in this.mcbx_loginHabits.value)
         {
            this._recruitmentData.selectedCriteria.push(value.typeId);
         }
         this._recruitmentData.recruitmentType = this.cbx_recruitmentMode.value.typeId;
         this._recruitmentData.minLevel = Number(this.inp_minLevelInput.text);
         this._recruitmentData.isMinLevelRequired = this.btn_isMinLevelRequired.selected;
         this._recruitmentData.minAchievementPoints = Number(this.inp_minAchievementPointsInput.text);
         this._recruitmentData.areMinAchievementPointsRequired = this.btn_areMinAchievementPointsRequired.selected;
         this.sysApi.sendAction(SendGuildRecruitmentDataAction.create(this._recruitmentData));
         this.uiApi.unloadUi(UIEnum.GUILD_PREZ_AND_RECRUIT);
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.inp_guildPresTitleInput:
               this.updateUiFromPresTitle();
               break;
            case this.inp_guildAdInput:
               this.updateUiFromAd();
               break;
            case this.inp_minLevelInput:
               this.updateUiFromMinLevel();
               break;
            case this.inp_minAchievementPointsInput:
               this.updateUiFromMinAchievementPoints();
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var guildInfo:GuildWrapper = null;
         var icon:EmblemSymbol = null;
         guildInfo = this.socialApi.getGuild();
         switch(target)
         {
            case this.tx_guildLogoBackground:
               this.utilApi.changeColor(this.tx_guildLogoBackground.getChildByName("back"),guildInfo.backEmblem.color,1);
               break;
            case this.tx_guildLogo:
               icon = this.dataApi.getEmblemSymbol(guildInfo.upEmblem.idEmblem);
               this.utilApi.changeColor(this.tx_guildLogo,guildInfo.upEmblem.color,0,!icon.colorizable);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var areRequiredCheckboxesVisible:* = false;
         if(target === this.cbx_recruitmentMode)
         {
            areRequiredCheckboxesVisible = this.cbx_recruitmentMode.value.typeId === GuildRecruitmentTypeEnum.AUTOMATIC;
            this.btn_isMinLevelRequired.visible = areRequiredCheckboxesVisible;
            this.btn_areMinAchievementPointsRequired.visible = areRequiredCheckboxesVisible;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var guildApplicationsUi:UiRootContainer = null;
         switch(target)
         {
            case this.mainCtr:
               guildApplicationsUi = this.uiApi.getUi(UIEnum.GUILD_PREZ_AND_RECRUIT);
               if(guildApplicationsUi !== null)
               {
                  guildApplicationsUi.setOnTop();
               }
               return;
            case this.btn_close:
               this.uiApi.unloadUi(UIEnum.GUILD_PREZ_AND_RECRUIT);
               return;
            case this.btn_save:
               this.sendRecruitmentSettings();
               return;
            case this.ctr_rulesLink:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.listOfRulesOfConduct"));
               return;
            default:
               return;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var mcbx:MultipleComboBox = null;
         var values:Array = null;
         var valuesToDisplay:Vector.<String> = null;
         var value:Object = null;
         var tooltipText:String = null;
         switch(target)
         {
            case this.mcbx_languages:
            case this.mcbx_goal:
            case this.mcbx_atmosphere:
            case this.mcbx_loginHabits:
               mcbx = target as MultipleComboBox;
               if(mcbx.isUnfolded)
               {
                  return;
               }
               values = mcbx.value;
               if(values.length <= 0)
               {
                  tooltipText = this.uiApi.getText("ui.guild.recruitment.noRequirements");
               }
               else
               {
                  if(target !== this.mcbx_languages)
                  {
                     values.sortOn("order",Array.NUMERIC);
                  }
                  else
                  {
                     values.sortOn("order",Array.CASEINSENSITIVE);
                  }
                  valuesToDisplay = new Vector.<String>(0);
                  for each(value in values)
                  {
                     valuesToDisplay.push(value.label);
                  }
                  tooltipText = valuesToDisplay.join("\n");
               }
               break;
            case this.tx_saveHint:
               if(this._recruitmentData !== null)
               {
                  tooltipText = this.uiApi.getText("ui.guild.recruitment.saveHint",this.timeApi.getDate(this._recruitmentData.lastEditDate),this._recruitmentData.lastEditorName);
               }
               break;
            case this.btn_save:
               if(!this.isSavePossible())
               {
                  tooltipText = this.uiApi.getText("ui.common.tooManyCharacters");
               }
               break;
            case this.tx_recruitmentWarning:
               if(this._recruitmentData !== null && this._recruitmentData.wasRecruitmentAutoLocked)
               {
                  tooltipText = this.uiApi.getText("ui.guild.recruitment.warning");
               }
         }
         if(tooltipText === null)
         {
            return;
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip(TOOLTIP_UI_NAME);
      }
      
      public function onShortcut(shortcutLabel:String) : Boolean
      {
         var me:UiRootContainer = null;
         if(shortcutLabel === ShortcutHookListEnum.CLOSE_UI)
         {
            me = this.uiApi.me();
            if(me === null)
            {
               this.sysApi.log(16,"GuildPrezAndRecruit: the current UI is null!");
               return false;
            }
            this.uiApi.unloadUi(me.name);
            return true;
         }
         return false;
      }
      
      private function onRecruitmentData(recruitmentData:GuildRecruitmentDataWrapper) : void
      {
         this.setRecruitmentData(recruitmentData);
      }
   }
}
