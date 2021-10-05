package Ankama_Grimoire.ui
{
   import Ankama_Grimoire.Grimoire;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.almanax.AlmanaxCalendar;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxEvent;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxMonth;
   import com.ankamagames.dofus.internalDatacenter.almanax.AlmanaxZodiac;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class CalendarTab
   {
      
      private static const NUMBER_OF_DAYS:int = 365;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _dateId:int;
      
      private var _monthInfo:AlmanaxMonth;
      
      private var _zodiacInfo:AlmanaxZodiac;
      
      private var _eventInfo:AlmanaxEvent;
      
      private var _calendar:AlmanaxCalendar;
      
      private var _meryde:Npc;
      
      private var _sheetsQuantity:int;
      
      public var lbl_day:Label;
      
      public var lbl_month:Label;
      
      public var lbl_year:Label;
      
      public var lbl_nameday:Label;
      
      public var lbl_titlemeryde:Label;
      
      public var lbl_meryde:TextArea;
      
      public var lbl_titleBonus:Label;
      
      public var lbl_bonus:TextArea;
      
      public var lbl_dayObjective:Label;
      
      public var lbl_quest:TextArea;
      
      public var lbl_questProgress:Label;
      
      public var ed_meryde:EntityDisplayer;
      
      public var btn_site:ButtonContainer;
      
      public var btn_locTemple:ButtonContainer;
      
      public var btn_hideDailyNotif:ButtonContainer;
      
      public var tx_astro:Texture;
      
      public var tx_monthGod:Texture;
      
      public var tx_nameDayIllu:Texture;
      
      public var tx_dolmanax:Texture;
      
      public var tx_progressBar:ProgressBar;
      
      public var tx_bgMeryde:Texture;
      
      public var ctr_nameDayIllu:GraphicContainer;
      
      public function CalendarTab()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.uiApi.addComponentHook(this.btn_locTemple,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_site,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_site,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_site,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_astro,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_astro,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_monthGod,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_monthGod,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ed_meryde,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ed_meryde,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_bgMeryde,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_bgMeryde,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_progressBar,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_progressBar,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_hideDailyNotif,ComponentHookList.ON_RELEASE);
         if(this.sysApi.getBuildType() == BuildTypeEnum.BETA)
         {
            this.btn_site.disabled = true;
         }
         this._sheetsQuantity = this.inventoryApi.getItemQty(DataEnum.ITEM_GID_CALENDAR_PAGE);
         var hideAlmanaxDailyNotif:* = this.sysApi.getData("hideAlmanaxDailyNotif");
         this.btn_hideDailyNotif.selected = hideAlmanaxDailyNotif != undefined ? !this.sysApi.getData("hideAlmanaxDailyNotif") : false;
         this.updateCalendarInfos();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function updateCalendarInfos() : void
      {
         var infos:Object = Grimoire.getInstance().calendarInfos;
         this._calendar = infos.calendar;
         this._monthInfo = infos.month;
         this._zodiacInfo = infos.zodiac;
         this._eventInfo = infos.event;
         this._meryde = infos.meryde;
         this.displayCalendar();
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      private function displayCalendar() : void
      {
         var qty:int = 0;
         this.lbl_day.text = "" + this.timeApi.getDofusDay();
         this.lbl_month.text = this.timeApi.getDofusMonth();
         this.lbl_year.text = this.uiApi.getText("ui.common.year",this.timeApi.getDofusYear());
         if(this._zodiacInfo)
         {
            this.tx_astro.uri = this.uiApi.createUri(this._zodiacInfo.webImageUrl);
         }
         if(this._monthInfo)
         {
            this.tx_monthGod.uri = this.uiApi.createUri(this._monthInfo.webImageUrl);
         }
         if(this._eventInfo)
         {
            this.lbl_nameday.text = this._eventInfo.name;
            this.tx_nameDayIllu.uri = this.uiApi.createUri(this._eventInfo.webImageUrl);
            this.lbl_meryde.text = this.getText(this._eventInfo.ephemeris);
         }
         if(this._meryde)
         {
            this.lbl_titlemeryde.text = this.uiApi.getText("ui.almanax.dayMeryde",this._meryde.name);
            this.ed_meryde.look = this._meryde.look;
            this.lbl_dayObjective.text = this.uiApi.getText("ui.almanax.offeringTo",this._meryde.name);
         }
         if(this._calendar)
         {
            this.lbl_titleBonus.text = this.uiApi.getText("ui.almanax.dayBonus") + this.uiApi.getText("ui.common.colon") + this._calendar.bonusName;
            this.lbl_bonus.text = this._calendar.bonusDescription;
         }
         var completedQuests:Vector.<uint> = this.questApi.getCompletedQuests();
         if(completedQuests && completedQuests.indexOf(954) == -1)
         {
            this.lbl_quest.text = this.uiApi.getText("ui.almanax.dolmanaxQuestDesc");
            this.lbl_questProgress.text = this.uiApi.getText("ui.almanax.questProgress");
            qty = this._sheetsQuantity > NUMBER_OF_DAYS ? int(NUMBER_OF_DAYS) : int(this._sheetsQuantity);
            this.tx_progressBar.value = qty / NUMBER_OF_DAYS;
         }
         else
         {
            this.lbl_quest.text = this.uiApi.getText("ui.almanax.dolmanaxQuestDone");
            this.lbl_questProgress.text = this.uiApi.getText("ui.almanax.questDone");
            this._sheetsQuantity = NUMBER_OF_DAYS;
            this.tx_progressBar.value = 1;
         }
         var dolmanax:Item = this.dataApi.getItem(DataEnum.ITEM_GID_DOLMANAX);
         if(dolmanax)
         {
            this.tx_dolmanax.uri = this.uiApi.createUri(this.uiApi.me().getConstant("item_path") + dolmanax.iconId + ".swf");
         }
      }
      
      private function getText(txt:String) : String
      {
         if(txt.indexOf("ui.") == 0)
         {
            return this.uiApi.getText(txt);
         }
         return txt;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_locTemple:
               this.sysApi.dispatchHook(HookList.AddMapFlag,"flag_teleportPoint",this.uiApi.getText("ui.almanax.sanctuary") + " (-4,-24)",1,-4,-24,15636787,true);
               break;
            case this.btn_site:
               this.sysApi.goToUrl(this.uiApi.getText("ui.almanax.link"));
               break;
            case this.btn_hideDailyNotif:
               this.sysApi.setData("hideAlmanaxDailyNotif",!this.btn_hideDailyNotif.selected);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var ttData:* = undefined;
         switch(target)
         {
            case this.btn_site:
               ttData = this.uiApi.getText("ui.almanax.goToWebsite");
               break;
            case this.tx_monthGod:
               if(this._monthInfo)
               {
                  ttData = this.getText(this._monthInfo.protectorDescription);
               }
               break;
            case this.tx_astro:
               if(this._zodiacInfo)
               {
                  ttData = this.getText(this._zodiacInfo.description);
               }
               break;
            case this.ed_meryde:
            case this.tx_bgMeryde:
               if(this._eventInfo)
               {
                  ttData = this.getText(this._eventInfo.bossText);
               }
               break;
            case this.tx_progressBar:
               ttData = this.uiApi.getText("ui.almanax.calendarSheetsCollected",this._sheetsQuantity,NUMBER_OF_DAYS);
         }
         if(ttData)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
