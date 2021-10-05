package Ankama_Mount.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.servers.ServerCommunity;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ExchangeHandleMountStableTypeEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class MountInfo
   {
      
      private static var _shortcutColor:String;
      
      private static const SHORTCUT_DISABLE_DURATION:Number = 500;
       
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _currentMount:Object;
      
      private var _paddockMode:Boolean;
      
      private var _centeredMode:Boolean;
      
      private var _aLblCap:Array;
      
      private var _serenityText:String;
      
      private var _playerMount:Boolean;
      
      private var _orangeColor:ColorTransform;
      
      private var _greenColor:ColorTransform;
      
      private var _shortcutTimerDuration:Number = 0;
      
      private var _certificat:Boolean = false;
      
      private var _currentTabName:String;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_window:GraphicContainer;
      
      public var btn_changeName:ButtonContainer;
      
      public var btn_xp:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_sterilize:ButtonContainer;
      
      public var btn_release:ButtonContainer;
      
      public var btn_storage:ButtonContainer;
      
      public var btn_ancestors:ButtonContainer;
      
      public var btn_mount:ButtonContainer;
      
      public var btn_feed:ButtonContainer;
      
      public var btn_stat:ButtonContainer;
      
      public var tx_icon_ctr_window:Texture;
      
      public var tx_icon_background_ctr_window:Texture;
      
      public var gd_effects:Grid;
      
      public var btn_effect:ButtonContainer;
      
      public var lbl_btn_effect:Label;
      
      public var lbl_name:Label;
      
      public var lbl_type:Label;
      
      public var lbl_level:Label;
      
      public var lbl_sex:Label;
      
      public var lbl_mountable:Label;
      
      public var lbl_wild:Label;
      
      public var lbl_xpTitle:Label;
      
      public var lbl_xp:Label;
      
      public var lbl_reproduction:Label;
      
      public var lbl_fecondation:Label;
      
      public var tx_mount:EntityDisplayer;
      
      public var pb_Energy:ProgressBar;
      
      public var pb_xp:ProgressBar;
      
      public var pb_tired:ProgressBar;
      
      public var pb_love:ProgressBar;
      
      public var pb_maturity:ProgressBar;
      
      public var pb_stamina:ProgressBar;
      
      public var pb_serenity:ProgressBar;
      
      public var tx_sex:TextureBitmap;
      
      public var ctr_stat:GraphicContainer;
      
      public var ctr_capacity:GraphicContainer;
      
      public var ctr_effect:GraphicContainer;
      
      public var lbl_love:Label;
      
      public var lbl_maturity:Label;
      
      public var lbl_stamina:Label;
      
      public var tx_love:TextureBitmap;
      
      public var tx_maturity:TextureBitmap;
      
      public var tx_stamina:TextureBitmap;
      
      public var lbl_cap0:Label;
      
      public var lbl_cap1:Label;
      
      public var lbl_cap2:Label;
      
      public var lbl_cap3:Label;
      
      public var lbl_serenity:Label;
      
      public function MountInfo()
      {
         super();
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(param:Object) : void
      {
         var currentMapdId:Number = NaN;
         var mapIsUnderWater:Boolean = false;
         var mountFamilyId:int = 0;
         this.sysApi.addHook(MountHookList.MountSterilized,this.onMountSterilized);
         this.sysApi.addHook(MountHookList.MountUnSet,this.onMountUnSet);
         this.sysApi.addHook(MountHookList.MountRiding,this.onMountRiding);
         this.sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         this.sysApi.addHook(MountHookList.MountRenamed,this.onMountRenamed);
         this.sysApi.addHook(MountHookList.MountXpRatio,this.onMountXpRatio);
         this.uiApi.addComponentHook(this.btn_changeName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_changeName,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_changeName,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_xp,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_xp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_xp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_stat,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_effect,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_release,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_release,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_release,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_sterilize,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_sterilize,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_sterilize,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_storage,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_storage,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_storage,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_ancestors,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_ancestors,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_ancestors,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_mount,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_mount,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_mount,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_feed,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_feed,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_feed,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_love,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_love,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_maturity,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_maturity,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_stamina,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_stamina,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_love,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_love,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_maturity,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_maturity,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_stamina,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_stamina,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_Energy,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_Energy,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_love,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_love,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_maturity,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_maturity,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_xp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_xp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_serenity,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_serenity,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_stamina,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_stamina,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_tired,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_tired,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_reproduction,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_reproduction,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_fecondation,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_fecondation,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_cap0,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_cap0,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_cap1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_cap1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_cap2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_cap2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_cap3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_cap3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.soundApi.playSound(SoundTypeEnum.OPEN_MOUNT_UI);
         this.btn_sterilize.soundId = SoundEnum.MOUNT_HURT;
         this._aLblCap = [this.lbl_cap0,this.lbl_cap1,this.lbl_cap2,this.lbl_cap3];
         this._orangeColor = new ColorTransform(1,1,1,1,71,-50,-146);
         this._greenColor = new ColorTransform(1,1,1,1,-100,0,-175);
         this._paddockMode = param.paddockMode;
         this._centeredMode = param.centeredMode;
         var mountInfo:UiRootContainer = this.uiApi.me();
         mountInfo.x = param.posX;
         mountInfo.y = param.posY;
         this.lbl_btn_effect.text = this.uiApi.processText(this.uiApi.getText("ui.common.effects"),"m",false);
         this.btn_stat.selected = true;
         this.ctr_effect.visible = false;
         this.ctr_capacity.visible = true;
         if(this.playerApi.isIncarnation())
         {
            this.btn_mount.disabled = true;
         }
         if(this._paddockMode)
         {
            this.tx_icon_ctr_window.uri = null;
            this.tx_icon_background_ctr_window.uri = null;
            this.btn_close.visible = false;
            this.btn_mount.visible = false;
            this.btn_storage.visible = false;
            this.btn_xp.visible = false;
            this.btn_feed.disabled = false;
            this.uiApi.me().visible = false;
            this.btn_changeName.visible = false;
            this.ctr_window.notMovableUIUnderConditions = true;
            this.ctr_window.dynamicPosition = true;
            this.btn_feed.x = this.uiApi.me().getConstant("btnFeedBarnPos");
            this.btn_ancestors.x = this.uiApi.me().getConstant("btnAncestorsBarnPos");
         }
         else if(this._centeredMode)
         {
            this.btn_mount.visible = false;
            this.btn_storage.visible = false;
            this.btn_sterilize.disabled = true;
            this.btn_release.disabled = true;
            this.btn_feed.disabled = false;
            this.btn_xp.visible = false;
            this.btn_changeName.visible = false;
            this.btn_feed.x = this.uiApi.me().getConstant("btnFeedBarnPos");
            this.btn_ancestors.x = this.uiApi.me().getConstant("btnAncestorsBarnPos");
         }
         else
         {
            this.btn_mount.visible = true;
            this.btn_storage.visible = true;
            this.btn_mount.selected = this.playerApi.isRidding();
            currentMapdId = this.playerApi.currentMap().mapId;
            mapIsUnderWater = this.mapApi.getMapPositionById(currentMapdId).isUnderWater;
            mountFamilyId = (param.mountData as MountData).model.familyId;
            if(mapIsUnderWater && mountFamilyId != 5)
            {
               this.btn_mount.softDisabled = true;
            }
         }
         if(!this._paddockMode)
         {
            if(this.playerApi.getMount() && this.playerApi.getMount().id == param.mountData.id)
            {
               this.showMountInformation(param.mountData,MountPaddock.SOURCE_EQUIP);
            }
            else
            {
               this.showMountInformation(param.mountData,MountPaddock.SOURCE_PADDOCK);
            }
         }
         this._currentMount = param.mountData;
         this.currentTabName = "btn_stat";
      }
      
      public function updateEffectLine(data:*, components:*, selected:Boolean) : void
      {
         if(data)
         {
            if(data is String)
            {
               components.lbl_effect.text = data;
            }
            else
            {
               components.lbl_effect.text = "• " + data.description;
            }
         }
         else
         {
            components.lbl_effect.text = "";
         }
      }
      
      public function showMountInformation(mount:Object, source:int) : void
      {
         var lblcap:* = undefined;
         var equipedMount:MountData = null;
         this._currentMount = mount;
         MountPaddock._currentSource = source;
         switch(source)
         {
            case MountPaddock.SOURCE_EQUIP:
            case MountPaddock.SOURCE_BARN:
               this.btn_changeName.visible = true;
               break;
            case MountPaddock.SOURCE_PADDOCK:
            case MountPaddock.SOURCE_INVENTORY:
               this.btn_changeName.visible = false;
         }
         this._certificat = source == MountPaddock.SOURCE_INVENTORY;
         if(mount)
         {
            this.uiApi.me().visible = true;
            if(!this._paddockMode)
            {
               this.btn_sterilize.disabled = true;
               equipedMount = this.playerApi.getMount();
               if(equipedMount && equipedMount.id == this._currentMount.id && this._currentMount.reproductionCount > -1)
               {
                  this.btn_sterilize.disabled = false;
               }
            }
            else
            {
               this.btn_sterilize.disabled = this._certificat;
               this.btn_feed.disabled = this._certificat;
            }
         }
         this.lbl_name.text = mount.name;
         this.lbl_type.text = mount.description;
         this.lbl_level.text = this.uiApi.getText("ui.common.averageLevel") + " " + mount.level;
         this.lbl_serenity.text = mount.serenity;
         if(mount.sex)
         {
            this.tx_sex.themeDataId = "tx_mount_female";
         }
         else
         {
            this.tx_sex.themeDataId = "tx_mount_male";
         }
         if(mount.isRideable)
         {
            this.lbl_mountable.text = this.uiApi.getText("ui.common.yes");
         }
         else
         {
            this.lbl_mountable.text = this.uiApi.getText("ui.common.no");
         }
         if(mount.isWild)
         {
            this.lbl_wild.text = this.uiApi.getText("ui.common.yes");
         }
         else
         {
            this.lbl_wild.text = this.uiApi.getText("ui.common.no");
         }
         this._serenityText = this._currentMount.aggressivityMax + "/" + this._currentMount.serenity + "/" + this._currentMount.serenityMax;
         this.tx_mount.look = this._currentMount.entityLook;
         var playerMount:MountData = this.playerApi.getMount();
         if(playerMount)
         {
            this._playerMount = playerMount.id == this._currentMount.id;
         }
         else
         {
            this._playerMount = false;
         }
         this.btn_feed.disabled = mount.maturity != mount.maturityForAdult;
         this.lbl_xp.visible = this._playerMount;
         this.lbl_xpTitle.visible = this._playerMount;
         this.btn_xp.visible = this._playerMount;
         this.pb_Energy.value = Number(mount.energy / mount.energyMax);
         if(mount.experienceForNextLevel != -1)
         {
            this.pb_xp.value = (mount.experience - mount.experienceForLevel) / (mount.experienceForNextLevel - mount.experienceForLevel);
         }
         else
         {
            this.pb_xp.value = 1;
         }
         this.pb_tired.value = mount.boostLimiter / mount.boostMax;
         if(mount.reproductionCount == -1)
         {
            this.lbl_reproduction.cssClass = "red";
            this.lbl_reproduction.text = this.uiApi.getText("ui.mount.castrated");
         }
         else if(mount.reproductionCount >= mount.reproductionCountMax)
         {
            this.lbl_reproduction.cssClass = "red";
            this.lbl_reproduction.text = this.uiApi.getText("ui.mount.sterilized");
         }
         else
         {
            this.lbl_reproduction.cssClass = "p";
            this.lbl_reproduction.text = mount.reproductionCount + "/" + mount.reproductionCountMax;
         }
         if(mount.fecondationTime > 0)
         {
            this.lbl_fecondation.visible = true;
            this.lbl_fecondation.text = this.uiApi.getText("ui.mount.fecondee") + " (" + mount.fecondationTime + " " + this.uiApi.processText(this.uiApi.getText("ui.time.hours"),"m",mount.fecondationTime == 1,mount.fecondationTime == 0) + ")";
            if(this.lbl_reproduction.visible)
            {
               this.lbl_fecondation.cssClass = "exoticright";
               this.lbl_fecondation.x = 160;
            }
            else
            {
               this.lbl_fecondation.cssClass = "exotic";
               this.lbl_fecondation.x = 10;
            }
         }
         else if(mount.isFecondationReady)
         {
            this.lbl_fecondation.visible = true;
            this.lbl_fecondation.cssClass = "bonus";
            this.lbl_fecondation.text = this.uiApi.getText("ui.mount.fecondable");
         }
         else
         {
            this.lbl_fecondation.visible = false;
         }
         this.lbl_xp.text = mount.xpRatio + "%";
         this.pb_love.value = mount.love / mount.loveMax;
         if(mount.love >= mount.loveMax * 0.75)
         {
            this.pb_love.barColor = this.uiApi.me().getConstant("progressBarGreen");
         }
         else
         {
            this.pb_love.barColor = this.uiApi.me().getConstant("progressBarOrange");
         }
         this.pb_maturity.value = mount.maturity / mount.maturityForAdult;
         if(mount.maturity >= mount.maturityForAdult)
         {
            this.pb_maturity.barColor = this.uiApi.me().getConstant("progressBarGreen");
         }
         else
         {
            this.pb_maturity.barColor = this.uiApi.me().getConstant("progressBarOrange");
         }
         this.pb_stamina.value = mount.stamina / mount.staminaMax;
         if(mount.stamina >= mount.staminaMax * 0.75)
         {
            this.pb_stamina.barColor = this.uiApi.me().getConstant("progressBarGreen");
         }
         else
         {
            this.pb_stamina.barColor = this.uiApi.me().getConstant("progressBarOrange");
         }
         var agm:int = mount.aggressivityMax;
         this.pb_serenity.value = (mount.serenity - agm) / (mount.serenityMax - agm);
         if(mount.serenity >= -2000 && mount.serenity <= 2000)
         {
            this.pb_serenity.barColor = this.uiApi.me().getConstant("progressBarGreen");
         }
         else
         {
            this.pb_serenity.barColor = this.uiApi.me().getConstant("progressBarOrange");
         }
         var nCapacity:int = mount.ability.length;
         var i:int = 0;
         for each(lblcap in this._aLblCap)
         {
            lblcap.text = "";
         }
         if(nCapacity)
         {
            this.ctr_capacity.visible = true;
            for(i = 0; i < nCapacity; i++)
            {
               this._aLblCap[i].text = "› " + mount.ability[i].name;
            }
         }
         else
         {
            this.ctr_capacity.visible = false;
         }
         var nEffect:int = mount.effectList.length;
         if(nEffect)
         {
            this.gd_effects.dataProvider = mount.effectList;
         }
         else
         {
            this.gd_effects.dataProvider = ["• " + this.uiApi.processText(this.uiApi.getText("ui.common.lowerNone"),"m",true)];
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function onChangeName(value:String) : void
      {
         var commu:ServerCommunity = this.sysApi.getCurrentServer().community;
         var namingRuleMountName:NamingRule = commu.namingRuleMountName;
         var regexp:RegExp = new RegExp(namingRuleMountName.regexp,"g");
         if(value.length >= namingRuleMountName.minLength && regexp.test(value))
         {
            this.sysApi.sendAction(new MountRenameRequestAction([value,this._currentMount.id]));
         }
      }
      
      private function onValidXpRatio(qty:Number) : void
      {
         this.sysApi.sendAction(new MountSetXpRatioRequestAction([qty]));
      }
      
      private function onConfirmCutMount() : void
      {
         if(this._paddockMode)
         {
            if(MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_STERILIZE,[this._currentMount.id]]));
            }
            else if(MountPaddock._currentSource == MountPaddock.SOURCE_BARN)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_STERILIZE,[this._currentMount.id]]));
            }
            else if(MountPaddock._currentSource == MountPaddock.SOURCE_PADDOCK)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_STERILIZE,[this._currentMount.id]]));
            }
         }
         else
         {
            this.sysApi.sendAction(new MountSterilizeRequestAction([]));
         }
      }
      
      private function onConfirmKillMount() : void
      {
         if(this._paddockMode)
         {
            if(MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_FREE,[this._currentMount.id]]));
            }
            else if(MountPaddock._currentSource == MountPaddock.SOURCE_INVENTORY)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_CERTIFICAT_FREE,[this._currentMount.id]]));
            }
            else if(MountPaddock._currentSource == MountPaddock.SOURCE_BARN)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_FREE,[this._currentMount.id]]));
            }
            else if(MountPaddock._currentSource == MountPaddock.SOURCE_PADDOCK)
            {
               this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_FREE,[this._currentMount.id]]));
            }
         }
         else
         {
            this.sysApi.sendAction(new MountReleaseRequestAction([]));
         }
         if(this.uiApi.getUi("storage") && this.uiApi.getUi("storage").properties.storageMod == "mount")
         {
            this.uiApi.unloadUi("storage");
         }
         if(this.uiApi.getUi("mountAncestors"))
         {
            this.uiApi.unloadUi("mountAncestors");
         }
         if(this.uiApi.getUi("feedUi") && this.uiApi.getUi("feedUi").properties.type == 3)
         {
            this.uiApi.unloadUi("feedUi");
         }
      }
      
      private function onMountSterilized(id:Number) : void
      {
         if(id == this._currentMount.id)
         {
            this.btn_sterilize.disabled = true;
            this.lbl_reproduction.text = this.uiApi.getText("ui.mount.castrated");
         }
      }
      
      private function onMountUnSet() : void
      {
         if(!this._paddockMode)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onMountRiding(isRiding:Boolean) : void
      {
         this.btn_mount.selected = isRiding;
      }
      
      private function onMountRenamed(id:Number, name:String) : void
      {
         if(id == this._currentMount.id)
         {
            this.lbl_name.text = name;
         }
      }
      
      private function onMountXpRatio(ratio:uint) : void
      {
         this.lbl_xp.text = ratio + "%";
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var param:Object = null;
         var i:int = 0;
         var capacityCount:int = 0;
         var data:Object = null;
         var textTooltip:String = "";
         var pos1:int = 6;
         var pos2:int = 0;
         var offset:int = 0;
         var shortcutKey:String = null;
         var ttWidth:uint = 0;
         if(target == this.btn_xp)
         {
            textTooltip = this.uiApi.getText("ui.mount.xpPercentTooltip");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_changeName)
         {
            textTooltip = this.uiApi.getText("ui.mount.renameTooltip");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_mount)
         {
            textTooltip = this.uiApi.getText("ui.mount.rideTooltip");
            pos1 = 7;
            pos2 = 1;
            shortcutKey = this.bindsApi.getShortcutBindStr("toggleRide");
            if(this.btn_mount.softDisabled)
            {
               textTooltip = this.uiApi.getText("ui.mount.underwaterRestriction");
               shortcutKey = null;
            }
         }
         else if(target == this.btn_storage)
         {
            textTooltip = this.uiApi.getText("ui.mount.inventoryAccess");
            shortcutKey = this.bindsApi.getShortcutBindStr("openMountStorage");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_ancestors)
         {
            textTooltip = this.uiApi.getText("ui.mount.ancestorTooltip");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_sterilize)
         {
            textTooltip = this.uiApi.getText("ui.mount.castrateTooltip");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_release)
         {
            textTooltip = this.uiApi.getText("ui.mount.killTooltip");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.btn_feed)
         {
            textTooltip = this.uiApi.getText("ui.mount.feed");
            pos1 = 7;
            pos2 = 1;
         }
         else if(target == this.lbl_love)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipLove");
            ttWidth = 300;
         }
         else if(target == this.lbl_maturity)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipMaturity");
            ttWidth = 300;
         }
         else if(target == this.lbl_stamina)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipStamina");
            ttWidth = 300;
         }
         else if(target == this.tx_stamina)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone1");
            pos1 = 1;
            pos2 = 7;
            offset = 10;
            ttWidth = 300;
         }
         else if(target == this.tx_maturity)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerToolTipZone2");
            pos1 = 1;
            pos2 = 7;
            offset = 10;
            ttWidth = 300;
         }
         else if(target == this.tx_love)
         {
            textTooltip = this.uiApi.getText("ui.mount.viewerTooltipZone3");
            pos1 = 1;
            pos2 = 7;
            offset = 10;
            ttWidth = 300;
         }
         if(!this._currentMount)
         {
            return;
         }
         if(target == this.pb_Energy)
         {
            textTooltip = this._currentMount.energy + "/" + this._currentMount.energyMax;
         }
         else if(target == this.pb_love)
         {
            textTooltip = this._currentMount.love + "/" + this._currentMount.loveMax;
         }
         else if(target == this.pb_maturity)
         {
            textTooltip = this._currentMount.maturity + "/" + this._currentMount.maturityForAdult;
         }
         else if(target == this.pb_serenity)
         {
            textTooltip = this._currentMount.aggressivityMax + "/" + this._currentMount.serenity + "/" + this._currentMount.serenityMax;
         }
         else if(target == this.pb_stamina)
         {
            textTooltip = this._currentMount.stamina + "/" + this._currentMount.staminaMax;
         }
         else if(target == this.pb_tired)
         {
            textTooltip = this._currentMount.boostLimiter + "/" + this._currentMount.boostMax;
         }
         else if(target == this.pb_xp)
         {
            if(this._currentMount.experienceForNextLevel != -1)
            {
               textTooltip = this._currentMount.experience - this._currentMount.experienceForLevel + "/" + (this._currentMount.experienceForNextLevel - this._currentMount.experienceForLevel);
            }
            else
            {
               textTooltip = this.uiApi.getText("ui.mount.maxLevel");
            }
         }
         else if(target == this.lbl_reproduction)
         {
            if(this._currentMount.reproductionCount == 20 || this._currentMount.reproductionCount == -1)
            {
               textTooltip = this.uiApi.getText("ui.mount.sterileTooltip");
            }
         }
         else if(target == this.lbl_fecondation)
         {
            if(this._currentMount.fecondationTime > 0)
            {
               textTooltip = this.uiApi.getText("ui.mount.timeToBirthTooltip");
            }
            else if(this._currentMount.isFecondationReady)
            {
               textTooltip = this.uiApi.getText("ui.mount.fecondableTooltip");
            }
         }
         else if(target.name.indexOf("lbl_cap") != -1)
         {
            capacityCount = this._currentMount.ability.length;
            for(i = 0; i < capacityCount; i++)
            {
               if(this._aLblCap[i] == target)
               {
                  textTooltip = this._currentMount.ability[i].description;
                  break;
               }
            }
         }
         if(textTooltip != "")
         {
            if(shortcutKey)
            {
               if(!_shortcutColor)
               {
                  _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut");
                  _shortcutColor = _shortcutColor.replace("0x","#");
               }
               data = this.uiApi.textTooltipInfo(textTooltip + " <font color=\'" + _shortcutColor + "\'>(" + shortcutKey + ")</font>",null,null,ttWidth);
            }
            else
            {
               data = this.uiApi.textTooltipInfo(textTooltip,null,null,ttWidth);
            }
            this.uiApi.showTooltip(data,target,false,"standard",pos1,pos2,offset,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_changeName:
               this.modCommon.openInputPopup(this.uiApi.getText("ui.mount.renameTooltip"),this.uiApi.getText("ui.mount.popupRename"),this.onChangeName,null,this._currentMount.name,"^ ",ProtocolConstantsEnum.MAX_RIDE_NAME_LEN);
               break;
            case this.btn_xp:
               this.modCommon.openQuantityPopup(0,90,this._currentMount.xpRatio,this.onValidXpRatio);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints(this.currentTabName);
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_sterilize:
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.mount.doUCastrateYourMount"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmCutMount,null]);
               break;
            case this.btn_release:
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.mount.doUKillYourMount"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmKillMount,null],this.onConfirmKillMount,function():void
               {
               });
               break;
            case this.btn_ancestors:
               if(!this.uiApi.getUi(UIEnum.MOUNT_ANCESTORS))
               {
                  this.uiApi.loadUi(UIEnum.MOUNT_ANCESTORS,UIEnum.MOUNT_ANCESTORS,{"mount":this._currentMount},StrataEnum.STRATA_TOP);
               }
               break;
            case this.btn_storage:
               if(this.playerApi.isInFight())
               {
                  this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.cantDoInFight"),666,this.timeApi.getTimestamp());
               }
               else
               {
                  this.sysApi.sendAction(new ExchangeRequestOnMountStockAction([]));
               }
               break;
            case this.btn_mount:
               if(this.shortcutTimerReady())
               {
                  this.sysApi.sendAction(new MountToggleRidingRequestAction([true]));
                  this.btn_mount.selected = false;
               }
               else
               {
                  this.btn_mount.selected = !this.btn_mount.selected;
               }
               break;
            case this.btn_feed:
               this.initFeed();
               break;
            case this.btn_stat:
               this.currentTabName = "btn_stat";
               this.ctr_stat.visible = true;
               this.ctr_capacity.visible = true;
               this.ctr_effect.visible = false;
               this.hintsApi.uiTutoTabLaunch();
               break;
            case this.btn_effect:
               this.currentTabName = "btn_effect";
               this.ctr_stat.visible = false;
               this.ctr_capacity.visible = true;
               this.ctr_effect.visible = true;
               this.hintsApi.uiTutoTabLaunch();
         }
      }
      
      private function shortcutTimerReady() : Boolean
      {
         var currentTime:int = getTimer();
         var ret:* = currentTime - this._shortcutTimerDuration > SHORTCUT_DISABLE_DURATION;
         this._shortcutTimerDuration = currentTime;
         return ret;
      }
      
      private function initFeed() : void
      {
         var foodList:Array = null;
         if((MountPaddock._currentSource == MountPaddock.SOURCE_EQUIP || MountPaddock._currentSource == MountPaddock.SOURCE_BARN) && (!this.playerApi.isInFight() || this.playerApi.isInPreFight()))
         {
            foodList = this.storageApi.getRideFoodsFor(this._currentMount.model.familyId);
            if(foodList.length)
            {
               this.sysApi.dispatchHook(HookList.OpenMountFeed,this._currentMount.id,this._currentMount.model.familyId,MountPaddock._currentSource,foodList);
            }
            else
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.item.errorNoFoodMount"),[this.uiApi.getText("ui.common.ok")]);
            }
         }
         else
         {
            this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.mount.impossibleFeed"),666,this.timeApi.getTimestamp());
         }
      }
      
      private function onMountSet() : void
      {
         this.showMountInformation(this.playerApi.getMount(),MountPaddock.SOURCE_EQUIP);
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            if(this._paddockMode)
            {
               return false;
            }
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
