package Ankama_Fight.ui.timeline
{
   import Ankama_Fight.Api;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import damageCalculation.tools.StatIds;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class Fighter
   {
      
      private static const SUMMONED_SCALE:Number = 0.8;
      
      private static const MINIMUM_LIFEBAR_WIDTH:uint = 2;
      
      private static var _framePool:Array = [];
      
      private static var _freeFrameId:uint = 0;
       
      
      private var _id:Number;
      
      private var _alive:Boolean = true;
      
      private var _isCurrentPlayer:Boolean = false;
      
      private var _summoned:Boolean;
      
      private var _hiddenInPrefight:Boolean;
      
      private var _lifePoints:int;
      
      private var _lifePointsThreshold:int;
      
      private var _shieldPoints:int;
      
      private var _risen:Boolean = false;
      
      private var _highlighted:Boolean = false;
      
      private var _clockStart:int;
      
      private var _turnDuration:int;
      
      private var _turnElapsedTime:uint;
      
      private var _timelineUi:Object;
      
      private var _selected:Boolean = false;
      
      private var _frame:ButtonContainer;
      
      private var _txSelected:Texture;
      
      private var _teamBackground:Texture;
      
      private var _teamDarkBackground:Texture;
      
      private var _teamTimeBackground:Texture;
      
      private var _txUnsorted:Texture;
      
      private var _timeMask:Sprite;
      
      private var _gfx:EntityDisplayer;
      
      private var _gfxMask:Sprite;
      
      private var _pdvGauge:ProgressBar;
      
      private var _pdvThresholdGauge:ProgressBar;
      
      private var _shieldGauge:ProgressBar;
      
      private var _lbl_number:Label;
      
      private var _lbl_waveNumber:Label;
      
      private var _minPdvGauge:uint;
      
      public function Fighter(id:Number, timelineUi:Object, num:uint)
      {
         super();
         this._id = id;
         var infos:FighterInformations = Api.fightApi.getFighterInformations(id);
         this._summoned = infos.summoner != 0 && infos.summoned;
         this._timelineUi = timelineUi;
         this._frame = this.createFrame(this._summoned);
         this._minPdvGauge = MINIMUM_LIFEBAR_WIDTH + this._pdvGauge.barPadding * 2;
         this.displayFighter(id,num);
      }
      
      private static function nextFrameName() : String
      {
         return "frame" + _freeFrameId++;
      }
      
      public static function cleanFramesPool() : void
      {
         _framePool = [];
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function get alive() : Boolean
      {
         return this._alive;
      }
      
      public function set alive(value:Boolean) : void
      {
         if(value != this._alive)
         {
            this.setAlive(value);
         }
      }
      
      public function get summoned() : Boolean
      {
         return this._summoned;
      }
      
      public function get hiddenInPrefight() : Boolean
      {
         return this._hiddenInPrefight;
      }
      
      public function set hiddenInPrefight(value:Boolean) : void
      {
         this._hiddenInPrefight = value;
      }
      
      public function get frame() : ButtonContainer
      {
         return this._frame;
      }
      
      public function get look() : Object
      {
         return this._gfx.look;
      }
      
      public function set look(object:Object) : void
      {
         this._gfx.look = object;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(this._selected != value)
         {
            this._txSelected.visible = value;
         }
         this._selected = value;
      }
      
      public function get clockStart() : int
      {
         return this._clockStart;
      }
      
      public function get turnDuration() : int
      {
         return this._turnDuration;
      }
      
      public function destroy(force:Boolean = false) : void
      {
         if(this._summoned || force)
         {
            this._frame.visible = false;
            this._lifePoints = 0;
         }
         Api.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function refreshHealthPoints() : void
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         if(stats !== null && this._alive)
         {
            this.setHealthPoints(stats.getHealthPoints());
         }
      }
      
      public function setHealthPoints(lifePoints:int) : void
      {
         var result:Number = NaN;
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         var maxLifePoints:Number = 1;
         if(stats !== null)
         {
            maxLifePoints = stats.getMaxHealthPoints();
         }
         if(lifePoints < 0)
         {
            lifePoints = 0;
         }
         this._lifePoints = lifePoints;
         var currentHeartRatio:Number = lifePoints / maxLifePoints;
         if(lifePoints === 0)
         {
            result = 0;
         }
         else
         {
            result = (this._minPdvGauge * (1 - currentHeartRatio) + currentHeartRatio * this._pdvGauge.width) / this._pdvGauge.width;
         }
         this._pdvGauge.value = result;
      }
      
      public function refreshPdvThreshold(threshold:uint) : void
      {
         if(this._alive)
         {
            this.setHealthPointsThreshold(threshold);
         }
      }
      
      public function setHealthPointsThreshold(lifePointsThreshold:int) : void
      {
         var result:Number = NaN;
         this._pdvThresholdGauge.barColor = Api.sysApi.getConfigEntry("colors.progressbar.lifeThreshold");
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         var maxLifePoints:Number = 1;
         if(stats !== null)
         {
            maxLifePoints = stats.getMaxHealthPoints();
         }
         if(lifePointsThreshold < 0)
         {
            lifePointsThreshold = 0;
         }
         var maxHealth:Number = maxLifePoints;
         if(lifePointsThreshold > maxHealth)
         {
            lifePointsThreshold = maxHealth;
         }
         this._lifePointsThreshold = lifePointsThreshold;
         var currentHeartRatio:Number = lifePointsThreshold / maxHealth;
         if(lifePointsThreshold === 0)
         {
            result = 0;
            this._pdvThresholdGauge.visible = false;
         }
         else
         {
            result = (this._minPdvGauge * (1 - currentHeartRatio) + currentHeartRatio * this._pdvGauge.width) / this._pdvGauge.width;
            this._pdvThresholdGauge.visible = true;
         }
         this._pdvThresholdGauge.width = result * this._pdvGauge.width;
      }
      
      public function refreshShieldPoints() : void
      {
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         if(stats !== null)
         {
            this.setShield(stats.getStatTotalValue(StatIds.SHIELD));
         }
      }
      
      public function setShield(currentShield:int) : void
      {
         var currentHeartPos:Number = NaN;
         var maskHeight:int = 0;
         var mask_height:int = this._timelineUi.getConstant("mask_height");
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         this._shieldPoints = currentShield;
         if(this._shieldPoints < 0)
         {
            this._shieldPoints = 0;
         }
         if(this._shieldPoints == 0)
         {
            this._shieldGauge.visible = false;
            this._gfxMask.height = mask_height;
         }
         else
         {
            this._shieldGauge.visible = true;
            currentHeartPos = this._shieldPoints / stats.getMaxHealthPoints();
            this._shieldGauge.value = currentHeartPos;
            maskHeight = mask_height - this._shieldGauge.height;
            this._gfxMask.height = maskHeight;
         }
      }
      
      public function startCountDown(turnDuration:int, remainingTime:uint) : void
      {
         this._turnDuration = turnDuration;
         this._clockStart = getTimer();
         this._turnElapsedTime = turnDuration - remainingTime;
         Api.sysApi.addEventListener(this.onEnterFrame,"Timeline");
         this._isCurrentPlayer = true;
         this._teamBackground.visible = false;
         this._timeMask.y = 0;
         var glow2:GlowFilter = new GlowFilter(16777215,0,1,1,2,BitmapFilterQuality.HIGH);
         this._gfx.filters = [glow2];
      }
      
      public function stopCountDown() : void
      {
         Api.sysApi.removeEventListener(this.onEnterFrame);
         this._isCurrentPlayer = false;
         this.updateTime(0);
         this._teamBackground.visible = true;
         this._timeMask.y = -this._teamTimeBackground.height;
         var glow:GlowFilter = new GlowFilter(16777215,0.2,20,20,2,BitmapFilterQuality.HIGH);
         this._gfx.filters = [glow];
      }
      
      public function pauseCountDown() : void
      {
         Api.sysApi.removeEventListener(this.onEnterFrame);
      }
      
      public function updateTime(value:Number = 0) : void
      {
         var height:Number = NaN;
         if(this.alive)
         {
            height = value * this._teamTimeBackground.height;
         }
         else
         {
            height = this._teamTimeBackground.height;
         }
         this._timeMask.y = -height;
      }
      
      public function updateSprite() : void
      {
         var infos:FighterInformations = Api.fightApi.getFighterInformations(this.id);
         if(this._gfx.look != infos.look)
         {
            this._gfx.look = infos.look;
         }
      }
      
      public function setRisen(value:Boolean, vertical:Boolean, direction:int) : void
      {
         this._risen = value;
         if(vertical)
         {
            if(value)
            {
               this._frame.x = direction * this._timelineUi.getConstant("frame_offset_horizontal");
            }
            else
            {
               this._frame.x = 0;
            }
         }
         else if(value)
         {
            this._frame.y = 0;
         }
         else
         {
            this._frame.y = direction * this._timelineUi.getConstant("frame_offset_vertical");
         }
         this._gfx.finalize();
      }
      
      public function get risen() : Boolean
      {
         return this._risen;
      }
      
      public function set highlight(value:Boolean) : void
      {
         this._highlighted = value;
         if(value)
         {
            this._teamBackground.luminosity = 1.5;
            this._teamDarkBackground.luminosity = 1.5;
            this._teamTimeBackground.luminosity = 1.5;
         }
         else
         {
            this._teamBackground.luminosity = 1;
            this._teamDarkBackground.luminosity = 1;
            this._teamTimeBackground.luminosity = 1;
         }
      }
      
      public function updateNumber(num:uint) : void
      {
         if(Api.configApi.getConfigProperty("dofus","orderFighters") && this._alive)
         {
            if(this._hiddenInPrefight && Api.playerApi.isInPreFight())
            {
               this._lbl_number.text = "?";
            }
            else
            {
               this._lbl_number.text = num.toString();
            }
         }
         else
         {
            this._lbl_number.text = "";
         }
      }
      
      public function updateUnsortedIcon() : void
      {
         this._txUnsorted.visible = this._hiddenInPrefight && Api.playerApi.isInPreFight();
      }
      
      public function get isCurrentPlayer() : Boolean
      {
         return this._isCurrentPlayer;
      }
      
      private function displayFighter(id:Number, num:uint) : void
      {
         var mask_height:int = 0;
         var mask_x:int = 0;
         var mask_y:int = 0;
         var mask_width:int = 0;
         var mask_corner:int = 0;
         var bmp_scale:Number = 1;
         mask_height = this._timelineUi.getConstant("mask_height");
         mask_x = this._timelineUi.getConstant("mask_x");
         mask_y = this._timelineUi.getConstant("mask_y");
         mask_width = this._timelineUi.getConstant("mask_width");
         mask_corner = this._timelineUi.getConstant("mask_corner");
         if(this._summoned)
         {
            mask_height *= SUMMONED_SCALE;
            mask_x *= SUMMONED_SCALE;
            mask_y *= SUMMONED_SCALE;
            mask_width *= SUMMONED_SCALE;
            mask_corner *= SUMMONED_SCALE;
            bmp_scale *= SUMMONED_SCALE;
         }
         var infos:FighterInformations = Api.fightApi.getFighterInformations(id);
         var stats:EntityStats = StatsManager.getInstance().getStats(this._id);
         this._gfx = Api.uiApi.createComponent("EntityDisplayer") as EntityDisplayer;
         this._gfx.width = mask_width;
         this._gfx.height = mask_height;
         this._gfx.view = "timeline";
         this._gfx.setAnimationAndDirection("AnimArtwork",1);
         this._gfx.look = infos.look;
         this._frame.addChild(this._gfx);
         var glow:GlowFilter = new GlowFilter(16777215,0.2,20,20,2,BitmapFilterQuality.HIGH);
         this._gfx.filters = [glow];
         this._gfxMask = new Sprite();
         this._gfxMask.graphics.beginFill(16733440);
         this._gfxMask.graphics.drawRect(mask_x,mask_y,mask_width,mask_height);
         this._gfxMask.graphics.endFill();
         this._frame.addChild(this._gfxMask);
         this._gfx.mask = this._gfxMask;
         if(!this._pdvGauge.finalized)
         {
            this._pdvGauge.finalize();
         }
         if(!this._pdvThresholdGauge.finalized)
         {
            this._pdvThresholdGauge.finalize();
         }
         if(!this._shieldGauge.finalized)
         {
            this._shieldGauge.finalize();
         }
         if(infos.team == "challenger")
         {
            this._teamBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_challenger"));
            this._teamDarkBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_dark_challenger"));
            this._teamTimeBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_highlight_challenger"));
            this._teamBackground.finalize();
            this._teamDarkBackground.finalize();
            this._teamTimeBackground.finalize();
         }
         else
         {
            this._teamBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_defender"));
            this._teamDarkBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_dark_defender"));
            this._teamTimeBackground.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_bg_highlight_defender"));
            this._teamBackground.finalize();
            this._teamDarkBackground.finalize();
            this._teamTimeBackground.finalize();
         }
         this._txSelected.finalize();
         this._lbl_number = Api.uiApi.createComponent("Label") as Label;
         this._lbl_number.width = 20;
         this._lbl_number.height = 16;
         this._lbl_number.x = mask_width - 19;
         this._lbl_number.y = -2;
         this._lbl_number.cssClass = "right";
         this._lbl_number.css = Api.uiApi.createUri(this._timelineUi.getConstant("css") + "small2.css");
         this.updateNumber(num);
         this._txUnsorted.x = (this._frame.width - this._txUnsorted.width) / 2;
         var glow2:GlowFilter = new GlowFilter(Api.sysApi.getConfigEntry("colors.text.glow.dark"),0.8,2,2,6,3);
         this._lbl_number.filters = [glow2];
         this._frame.addChild(this._lbl_number);
         this._lbl_waveNumber = Api.uiApi.createComponent("Label") as Label;
         this._lbl_waveNumber.width = 20;
         this._lbl_waveNumber.height = 16;
         this._lbl_waveNumber.x = -2;
         this._lbl_waveNumber.y = -2;
         this._lbl_waveNumber.css = Api.uiApi.createUri(this._timelineUi.getConstant("css") + "small2.css");
         if(infos.wave > 0)
         {
            this._lbl_waveNumber.text = infos.wave.toString();
         }
         else
         {
            this._lbl_waveNumber.text = "";
         }
         this._lbl_waveNumber.filters = [glow2];
         this._frame.addChild(this._lbl_waveNumber);
         this.setHealthPoints(stats.getHealthPoints());
         this.updateTime(0);
      }
      
      private function createFrame(summoned:Boolean) : ButtonContainer
      {
         var frame:ButtonContainer = null;
         var stateChangingProperties:Array = null;
         var state:int = 0;
         if(summoned && _framePool.length > 0)
         {
            frame = _framePool.pop();
            this._pdvGauge = frame.getChildByName("pb_pdvGauge") as ProgressBar;
            this._pdvThresholdGauge = frame.getChildByName("pb_pdvThresholdGauge") as ProgressBar;
            this._shieldGauge = frame.getChildByName("pb_shieldGauge") as ProgressBar;
            this._teamBackground = frame.getChildByName("tx_background") as Texture;
            this._teamDarkBackground = frame.getChildByName("tx_darkBackground") as Texture;
            this._teamTimeBackground = frame.getChildByName("tx_timeBackground") as Texture;
            this._timeMask = frame.getChildByName("time_mask") as Sprite;
            this._txSelected = frame.getChildByName("tx_selected") as Texture;
            frame.visible = true;
         }
         else
         {
            frame = Api.uiApi.createContainer("ButtonContainer") as ButtonContainer;
            if(summoned)
            {
               frame.width = this._timelineUi.getConstant("frame_summon_width");
               frame.height = this._timelineUi.getConstant("frame_summon_height");
            }
            else
            {
               frame.width = this._timelineUi.getConstant("frame_char_width");
               frame.height = this._timelineUi.getConstant("frame_char_height");
            }
            frame.name = nextFrameName();
            frame.y = this._timelineUi.getConstant("frame_offset_vertical");
            this._teamBackground = Api.uiApi.createComponent("Texture") as Texture;
            this._teamBackground.width = frame.width;
            this._teamBackground.height = frame.height;
            this._teamBackground.name = "tx_background";
            this._teamBackground.dispatchMessages = true;
            this._teamDarkBackground = Api.uiApi.createComponent("Texture") as Texture;
            this._teamDarkBackground.width = frame.width;
            this._teamDarkBackground.height = frame.height;
            this._teamDarkBackground.name = "tx_darkBackground";
            this._teamDarkBackground.dispatchMessages = true;
            this._teamTimeBackground = Api.uiApi.createComponent("Texture") as Texture;
            this._teamTimeBackground.width = frame.width;
            this._teamTimeBackground.height = frame.height;
            this._teamTimeBackground.name = "tx_timeBackground";
            this._teamTimeBackground.dispatchMessages = true;
            this._timeMask = new Sprite();
            this._timeMask.name = "time_mask";
            this._timeMask.graphics.beginFill(16733440);
            this._timeMask.graphics.drawRect(0,frame.height,frame.width,frame.height);
            this._timeMask.graphics.endFill();
            this._txSelected = Api.uiApi.createComponent("Texture") as Texture;
            this._txSelected.x = 0;
            this._txSelected.y = 0;
            this._txSelected.width = frame.width;
            this._txSelected.height = frame.height + 2;
            this._txSelected.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_selection"));
            this._txSelected.name = "tx_selected";
            this._txSelected.visible = false;
            this._txUnsorted = Api.uiApi.createComponent("Texture") as Texture;
            this._txUnsorted.x = 0;
            this._txUnsorted.y = this._timelineUi.getConstant("unsorted_icon_y");
            this._txUnsorted.width = this._timelineUi.getConstant("unsorted_icon_width");
            this._txUnsorted.height = this._timelineUi.getConstant("unsorted_icon_height");
            this._txUnsorted.uri = Api.uiApi.createUri(this._timelineUi.getConstant("texture_unsorted"));
            this._txUnsorted.name = "tx_unsorted";
            this._txUnsorted.visible = false;
            this._txUnsorted.finalize();
            this._pdvGauge = Api.uiApi.createComponent("ProgressBar") as ProgressBar;
            this._pdvGauge.name = "pb_pdvGauge";
            this._pdvGauge.barColor = Api.sysApi.getConfigEntry("colors.progressbar.lifePoints");
            this._pdvThresholdGauge = Api.uiApi.createComponent("ProgressBar") as ProgressBar;
            this._pdvThresholdGauge.name = "pb_pdvThresholdGauge";
            this._pdvThresholdGauge.barColor = Api.sysApi.getConfigEntry("colors.progressbar.lifeThreshold");
            if(summoned)
            {
               this._pdvGauge.width = this._timelineUi.getConstant("pdv_summon_width");
               this._pdvGauge.height = this._pdvThresholdGauge.height = this._timelineUi.getConstant("pdv_summon_height");
               this._pdvGauge.x = this._pdvThresholdGauge.x = this._timelineUi.getConstant("pdv_summon_x");
               this._pdvGauge.y = this._pdvThresholdGauge.y = this._timelineUi.getConstant("pdv_summon_y");
            }
            else
            {
               this._pdvGauge.width = this._timelineUi.getConstant("pdv_width");
               this._pdvGauge.height = this._pdvThresholdGauge.height = this._timelineUi.getConstant("pdv_height");
               this._pdvGauge.x = this._pdvThresholdGauge.x = this._timelineUi.getConstant("pdv_x");
               this._pdvGauge.y = this._pdvThresholdGauge.y = this._timelineUi.getConstant("pdv_y");
            }
            this.setHealthPointsThreshold(0);
            this._pdvThresholdGauge.value = 1;
            this._pdvGauge.finalize();
            this._pdvThresholdGauge.finalize();
            this._shieldGauge = Api.uiApi.createComponent("ProgressBar") as ProgressBar;
            this._shieldGauge.name = "pb_shieldGauge";
            this._shieldGauge.barColor = Api.sysApi.getConfigEntry("colors.progressbar.shieldPoints");
            if(summoned)
            {
               this._shieldGauge.width = this._timelineUi.getConstant("pdv_summon_width");
               this._shieldGauge.height = this._timelineUi.getConstant("pdv_summon_height");
               this._shieldGauge.x = this._timelineUi.getConstant("shield_summon_x");
               this._shieldGauge.y = this._timelineUi.getConstant("shield_summon_y");
            }
            else
            {
               this._shieldGauge.width = this._timelineUi.getConstant("pdv_width");
               this._shieldGauge.height = this._timelineUi.getConstant("pdv_height");
               this._shieldGauge.x = this._timelineUi.getConstant("shield_x");
               this._shieldGauge.y = this._timelineUi.getConstant("shield_y");
            }
            this._shieldGauge.visible = false;
            this._shieldGauge.finalize();
            frame.addChild(this._teamDarkBackground);
            frame.addChild(this._teamTimeBackground);
            frame.addChild(this._timeMask);
            this._teamTimeBackground.mask = this._timeMask;
            frame.addChild(this._teamBackground);
            frame.addChild(this._txSelected);
            frame.addChild(this._shieldGauge);
            frame.addChild(this._pdvGauge);
            frame.addChild(this._pdvThresholdGauge);
            frame.addChild(this._txUnsorted);
            stateChangingProperties = [];
            state = StatesEnum.STATE_OVER;
            stateChangingProperties[state] = [];
            stateChangingProperties[state][this._pdvGauge.name] = [];
            stateChangingProperties[state][this._pdvGauge.name]["luminosity"] = 1.5;
            stateChangingProperties[state][this._pdvThresholdGauge.name] = [];
            stateChangingProperties[state][this._pdvThresholdGauge.name]["luminosity"] = 1.5;
            stateChangingProperties[state][this._shieldGauge.name] = [];
            stateChangingProperties[state][this._shieldGauge.name]["luminosity"] = 1.5;
            frame.changingStateData = stateChangingProperties;
         }
         return frame;
      }
      
      private function setAlive(alive:Boolean) : void
      {
         var stats:EntityStats = null;
         var glow:GlowFilter = null;
         this._alive = alive;
         if(this._alive)
         {
            stats = StatsManager.getInstance().getStats(this._id);
            this.setHealthPoints(stats.getHealthPoints());
            this._gfx.transform.colorTransform = new ColorTransform();
            glow = new GlowFilter(16777215,0.2,20,20,2,BitmapFilterQuality.HIGH);
            this._gfx.filters = [glow];
         }
         else
         {
            this.setHealthPoints(0);
            this.setShield(0);
            this._gfx.transform.colorTransform = new ColorTransform(0.6,0.6,0.6,0.7);
            this._gfx.filters = [];
         }
         this.updateTime(0);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var clock:uint = getTimer();
         var percentTime:Number = (clock - this._clockStart + this._turnElapsedTime) / this._turnDuration;
         if(this._isCurrentPlayer)
         {
            this.updateTime(percentTime);
         }
      }
   }
}
