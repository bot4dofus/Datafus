package Ankama_Cartography.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   import flash.utils.describeType;
   
   public class CartographyTool
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var input_mapId:Input;
      
      public var input_mapWidth:Input;
      
      public var input_mapHeight:Input;
      
      public var input_originX:Input;
      
      public var input_originY:Input;
      
      public var btn_close:ButtonContainer;
      
      public var btn_import:ButtonContainer;
      
      public var btn_reset:ButtonContainer;
      
      public var tx_help:Texture;
      
      private var _uiCartography:AbstractCartographyUi;
      
      private var _timer:BenchmarkTimer;
      
      public function CartographyTool()
      {
         this._timer = new BenchmarkTimer(400,0,"CartographyTool._timer");
         super();
      }
      
      public function get uiCartography() : AbstractCartographyUi
      {
         if(this.uiApi.getUi("cartographyUi"))
         {
            this._uiCartography = UiRootContainer(this.uiApi.getUi("cartographyUi")).uiClass;
         }
         else
         {
            this._uiCartography = null;
         }
         return this._uiCartography;
      }
      
      public function main(params:Array) : void
      {
         var worldmap:WorldMap = this.dataApi.getWorldMap(params[0]);
         if(worldmap)
         {
            this.input_mapId.text = worldmap.id.toString();
            this.input_mapWidth.text = worldmap.mapWidth.toString();
            this.input_mapHeight.text = worldmap.mapHeight.toString();
            this.input_originX.text = worldmap.origineX.toString();
            this.input_originY.text = worldmap.origineY.toString();
         }
         this.uiApi.addComponentHook(this.input_mapId,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_mapWidth,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_mapHeight,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_originX,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.input_originY,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_import,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_import,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_import,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_reset,ComponentHookList.ON_ROLL_OUT);
      }
      
      public function onChange(target:Input) : void
      {
         this._timer.reset();
         this._timer.addEventListener(TimerEvent.TIMER,this.refresh,false,0,true);
         this._timer.start();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var pos:WorldPointWrapper = null;
         var pt:* = undefined;
         var worldmap:WorldMap = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_import:
               if(!this.uiCartography)
               {
                  return;
               }
               pos = this.playerApi.currentMap();
               pt = this.uiCartography.mapViewer.getOrigineFromPos(pos.outdoorX,pos.outdoorY);
               this.input_originX.text = pt.x;
               this.input_originY.text = pt.y;
               break;
            case this.btn_reset:
               if(!this.uiCartography)
               {
                  return;
               }
               worldmap = this.dataApi.getWorldMap(parseInt(this.input_mapId.text));
               this.input_originX.text = worldmap.origineX.toString();
               this.input_originY.text = worldmap.origineY.toString();
               this.input_mapWidth.text = worldmap.mapWidth.toString();
               this.input_mapHeight.text = worldmap.mapHeight.toString();
               CartographyBase(this.uiCartography).openNewMap(worldmap,CartographyBase.MAP_TYPE_SUPERAREA,this.uiCartography.currentSuperarea,true);
               break;
         }
      }
      
      public function unload() : void
      {
         this._timer.removeEventListener(TimerEvent.TIMER,this.refresh);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var maxTooltipWidth:uint = 400;
         switch(target)
         {
            case this.btn_import:
               tooltipText = "Calcul l\'origine X/Y du coin haut gauche de l\'écran sur la map";
               break;
            case this.btn_reset:
               tooltipText = "Recharge les valeurs depuis les fichiers de données";
               break;
            case this.tx_help:
               tooltipText = "Instructions :\n" + " 1 - Se téléporter dans la zone de la carte\n" + " 2 - Déplacer la carte de sorte que la position actuelle du joueur se trouve en haut à gauche de l\'écran\n" + " 3 - Cliquer sur le bouton <b>Calculs</b>\n" + " 4 - Ajuster les différentes valeurs";
               maxTooltipWidth = 800;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText,null,null,maxTooltipWidth),target,false,"standard",LocationEnum.POINT_LEFT,LocationEnum.POINT_RIGHT,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function refresh(e:*) : void
      {
         var key:String = null;
         this._timer.removeEventListener(TimerEvent.TIMER,this.refresh);
         if(!this.uiCartography)
         {
            return;
         }
         var worldmap:WorldMap = this.dataApi.getWorldMap(parseInt(this.input_mapId.text));
         var worldmapCopy:Object = {};
         var objDesc:XML = describeType(worldmap);
         for each(key in objDesc..variable.@name)
         {
            worldmapCopy[key] = worldmap[key];
         }
         worldmapCopy.origineX = parseInt(this.input_originX.text);
         worldmapCopy.origineY = parseInt(this.input_originY.text);
         worldmapCopy.mapWidth = parseFloat(this.input_mapWidth.text);
         worldmapCopy.mapHeight = parseFloat(this.input_mapHeight.text);
         CartographyBase(this._uiCartography).openNewMap(worldmapCopy,CartographyBase.MAP_TYPE_SUPERAREA,this._uiCartography.currentSuperarea,true);
      }
   }
}
