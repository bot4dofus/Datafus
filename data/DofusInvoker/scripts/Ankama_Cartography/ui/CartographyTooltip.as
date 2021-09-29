package Ankama_Cartography.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.network.enums.CompassTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class CartographyTooltip
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var ctr_flags:GraphicContainer;
      
      public var ctr_flags_bg:GraphicContainer;
      
      public var ctr_flags_bgHeight:int;
      
      public var gd_flags:Grid;
      
      public var ctr_mapElements:GraphicContainer;
      
      public var ctr_mapElements_bg:GraphicContainer;
      
      public var ctr_coords:GraphicContainer;
      
      public var ctr_mapElements_bgHeight:int;
      
      public var gd_mapElements:Grid;
      
      public var lbl_coords:Label;
      
      public var totalHeight:Number;
      
      private var _numElements:uint;
      
      private var _numFlags:uint;
      
      private var _mapElementHeight:int;
      
      private var _mapFlagElementHeight:int;
      
      private var _lastParams:Object;
      
      private var _maxWidth:uint;
      
      private var _ctrMapElementsWidth:uint;
      
      private var _subAreaName:String;
      
      private var _myPositionUri:String;
      
      private var _labelDefaultX:Number;
      
      private var _elementsIds:Vector.<String>;
      
      private var _flagsIds:Vector.<String>;
      
      private var _containers:Dictionary;
      
      public function CartographyTooltip()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._myPositionUri = this.sysApi.getConfigEntry("config.gfx.path") + "icons/hints/character.png";
         this._labelDefaultX = this.uiApi.me().getConstant("labelTextX");
         this._mapFlagElementHeight = this.uiApi.me().getConstant("mapFlagElementHeight");
         this._mapElementHeight = this.uiApi.me().getConstant("mapElementHeight");
         this.update(oParam);
      }
      
      public function update(oParam:Object) : void
      {
         var elementsNames:Vector.<String> = null;
         var flags:Array = null;
         var mapElements:Array = null;
         var assetName:String = null;
         var flagPriority:int = 0;
         var i:int = 0;
         this.totalHeight = 0;
         var subArea:SubArea = this.dataApi.getSubArea(oParam.subAreaId);
         this._subAreaName = !!subArea ? subArea.name : null;
         this.lbl_coords.text = "[" + oParam.mapX + "," + oParam.mapY + "]";
         this.ctr_coords.visible = oParam.showMapCoords;
         if(!this.ctr_coords.visible)
         {
            this.ctr_mapElements_bg.y = this.gd_mapElements.y = this.ctr_coords.y;
         }
         this.ctr_flags.height = 0;
         this.ctr_flags.width = 0;
         this.ctr_flags_bg.width = 0;
         this.ctr_flags_bgHeight = 0;
         this._ctrMapElementsWidth = 0;
         this.ctr_mapElements.width = 0;
         this._maxWidth = 0;
         this.ctr_mapElements_bg.width = 0;
         this.ctr_mapElements_bgHeight = 0;
         if(oParam.mapElements)
         {
            elementsNames = new Vector.<String>(0);
            flags = new Array();
            mapElements = new Array();
            for(i = 0; i < oParam.mapElements.length; i++)
            {
               if(elementsNames.indexOf(oParam.mapElements[i].text) == -1 && (oParam.mapElements[i].element.id.indexOf("search_flag") == -1 || oParam.hasOwnProperty("mouseOnArrow") && oParam.mouseOnArrow == true))
               {
                  assetName = oParam.mapElements[i].element.textureName;
                  if(assetName.indexOf("|") != -1)
                  {
                     assetName = assetName.split("|")[1];
                  }
                  if(assetName && (assetName == "point0" || assetName == "myPosition" || assetName == "myPosition2" || assetName == "character.png" || assetName == "flag.png" || assetName.indexOf("flag") != -1))
                  {
                     flagPriority = -1;
                     if(oParam.mapElements[i].element.id == "flag_playerPosition" || oParam.mapElements[i].element.id == "center")
                     {
                        flagPriority = 2;
                     }
                     else if(oParam.mapElements[i].element.id.indexOf("flag_srv" + CompassTypeEnum.COMPASS_TYPE_QUEST) != -1)
                     {
                        flagPriority = 1;
                     }
                     else if(oParam.mapElements[i].element.id.indexOf("Phoenix") != -1)
                     {
                        flagPriority = 0;
                     }
                     flags.push({
                        "elem":oParam.mapElements[i],
                        "priority":flagPriority
                     });
                  }
                  else
                  {
                     mapElements.push(oParam.mapElements[i]);
                  }
                  elementsNames.push(oParam.mapElements[i].text);
               }
            }
            flags.sortOn("priority",Array.DESCENDING | Array.NUMERIC);
            for(i = 0; i < flags.length; i++)
            {
               flags[i] = flags[i].elem;
            }
            this._elementsIds = new Vector.<String>(0);
            this._flagsIds = new Vector.<String>(0);
            this._containers = new Dictionary();
            this._numElements = mapElements.length;
            for(i = 0; i < mapElements.length; i++)
            {
               this._elementsIds.push(mapElements[i].element.id);
            }
            this.gd_mapElements.finalized = false;
            this.gd_mapElements.dataProvider = mapElements;
            this.gd_mapElements.height = this._numElements * this._mapElementHeight;
            this._numFlags = flags.length;
            this.gd_flags.finalized = false;
            for(i = 0; i < flags.length; i++)
            {
               this._flagsIds.push(flags[i].element.id);
            }
            this.gd_flags.dataProvider = flags;
            this.gd_flags.height = this._numFlags * this._mapFlagElementHeight;
            this.ctr_flags.height = this.gd_flags.height;
         }
         else
         {
            this.gd_flags.dataProvider = [];
            this.gd_mapElements.dataProvider = [];
            this._numElements = 0;
            this._numFlags = 0;
         }
         this.ctr_mapElements_bg.visible = this._numElements > 0;
         this.ctr_flags.visible = this._numFlags > 0;
         this._lastParams = oParam;
         if(this._maxWidth > 0)
         {
            this.ctr_mapElements.width = this._maxWidth;
            this.ctr_flags.width = this._maxWidth;
         }
         else
         {
            this.ctr_mapElements.width = this.ctr_mapElements.contentWidth;
            this.ctr_flags.width = this.ctr_flags.contentWidth;
         }
         this.uiApi.me().render();
         this.ctr_mapElements_bg.height = this.ctr_mapElements_bgHeight > 0 ? Number(this.ctr_mapElements_bgHeight) : Number(this.gd_mapElements.height + 10);
         this.ctr_flags_bg.height = this.ctr_flags_bgHeight > 0 ? Number(this.ctr_flags_bgHeight) : Number(this.gd_flags.height + 10);
         if(!this._numFlags)
         {
            this.ctr_mapElements.y = 0;
         }
         else
         {
            this.ctr_mapElements.y = this.ctr_flags_bg.height + 5;
         }
         this.totalHeight = 40;
         if(this.ctr_mapElements_bg.visible)
         {
            this.totalHeight += this.ctr_mapElements_bg.height;
         }
         if(this.ctr_flags.visible)
         {
            this.totalHeight += this.ctr_flags_bg.height;
         }
      }
      
      public function updateFlag(data:Object, components:*, selected:Boolean) : void
      {
         var ctrWidth:Number = NaN;
         if(data)
         {
            components.tx_icon.visible = true;
            this.updateElement(this.gd_flags,data,components);
            ctrWidth = components.lbl_text.x + components.lbl_text.width;
            this._maxWidth = Math.max(Math.max(ctrWidth,this._maxWidth),this._ctrMapElementsWidth);
         }
         else
         {
            components.tx_icon.visible = false;
            components.lbl_text.text = "";
         }
      }
      
      public function updateMapElement(mapElementData:Object, components:*, selected:Boolean) : void
      {
         if(mapElementData)
         {
            components.tx_icon.visible = true;
            this.updateElement(this.gd_mapElements,mapElementData,components);
            this._ctrMapElementsWidth = Math.max(components.lbl_text.x + components.lbl_text.width,this._ctrMapElementsWidth);
         }
         else
         {
            components.tx_icon.visible = false;
            components.lbl_text.text = "";
         }
      }
      
      public function hasElement(pElementId:String) : Boolean
      {
         var mapElement:Object = null;
         if(this._lastParams.mapElements)
         {
            for each(mapElement in this._lastParams.mapElements)
            {
               if(mapElement.element.id == pElementId)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function updateElement(grid:Grid, data:Object, components:*) : void
      {
         var ids:Vector.<String> = null;
         var bg:GraphicContainer = null;
         var i:int = 0;
         var R:* = 0;
         var V:* = 0;
         var B:* = 0;
         var ct:ColorTransform = null;
         var offsetY:int = 0;
         var uri:* = data.element.uri;
         var color:int = data.element.color;
         var ss:Array = !!uri ? uri.split("/") : null;
         var assetName:String = !!ss ? ss[ss.length - 1] : null;
         var isFlag:Boolean = !!assetName ? assetName.indexOf("flag") != -1 : false;
         if(assetName && assetName.indexOf("myPosition") != -1)
         {
            uri = this.sysApi.getConfigEntry("config.gfx.path") + "icons/hints/character.png";
         }
         else if(isFlag)
         {
            uri = this.sysApi.getConfigEntry("config.gfx.path") + "icons/hints/flag.png";
         }
         else if((this.playerApi.isInBreach() || this.playerApi.currentSubArea().id == 904) && data.element.id.indexOf("breachIcon") != -1)
         {
            uri = null;
         }
         if(uri)
         {
            ss = uri.split("|");
            if(uri.indexOf("hintsShadow") != -1)
            {
               uri = uri.replace("hintsShadow","hints");
            }
            components.tx_icon.uri = this.uiApi.createUri(ss.length > 1 && ss[1] == "myPosition" ? this._myPositionUri : uri);
            components.tx_icon.visible = true;
            components.lbl_text.x = this._labelDefaultX;
         }
         else
         {
            components.tx_icon.visible = false;
            components.lbl_text.x = 0;
         }
         if(color != -1)
         {
            R = color >> 16 & 255;
            V = color >> 8 & 255;
            B = color >> 0 & 255;
            ct = new ColorTransform(0.6,0.6,0.6,1,R - 80,V - 80,B - 80);
            components.tx_icon.transform.colorTransform = ct;
         }
         else
         {
            components.tx_icon.transform.colorTransform = new ColorTransform();
         }
         components.lbl_text.text = data.text + (assetName == "410.png" && this._subAreaName ? " - " + this._subAreaName : "");
         components.lbl_text.width = 0;
         components.lbl_text.fullWidthAndHeight();
         this._containers[data.element.id] = {
            "container":components.lbl_text.getParent(),
            "label":components.lbl_text
         };
         if(grid == this.gd_mapElements)
         {
            ids = this._elementsIds;
            bg = this.ctr_mapElements_bg;
         }
         else
         {
            ids = this._flagsIds;
            bg = this.ctr_flags_bg;
         }
         var allElementsUpdated:Boolean = true;
         for(i = 0; i < ids.length; i++)
         {
            if(!this._containers[ids[i]])
            {
               allElementsUpdated = false;
               break;
            }
         }
         if(allElementsUpdated)
         {
            for(i = 0; i < ids.length; i++)
            {
               this._containers[ids[i]].container.y = 5;
            }
            offsetY = 0;
            for(i = 0; i < ids.length; i++)
            {
               this._containers[ids[i]].container.y += offsetY;
               offsetY += this._containers[ids[i]].label.textHeight - 18;
            }
            if(grid == this.gd_mapElements)
            {
               this.ctr_mapElements_bgHeight = ids.length * this._mapElementHeight + offsetY + 10;
               this.ctr_mapElements_bg.height = this.ctr_mapElements_bgHeight;
            }
            else
            {
               this.ctr_flags_bgHeight = ids.length * this._mapFlagElementHeight + offsetY + 10;
               this.ctr_flags_bg.height = this.ctr_flags_bgHeight;
            }
         }
      }
   }
}
