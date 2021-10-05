package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MapViewer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.utils.getQualifiedClassName;
   import gs.TweenMax;
   import gs.events.TweenEvent;
   
   public class MapGroupElement extends Sprite
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapGroupElement));
      
      protected static var glowFilter:GlowFilter;
      
      protected static var cssUri:Uri;
       
      
      private var _icons:Vector.<MapIconElement>;
      
      private var _initialPos:Array;
      
      private var _tween:Array;
      
      private var _shape:Shape;
      
      private var _open:Boolean;
      
      private var _mapviewer:MapViewer;
      
      private var _iconsNumberLabel:Label;
      
      public function MapGroupElement(mapViewer:MapViewer)
      {
         this._initialPos = [];
         super();
         this._icons = new Vector.<MapIconElement>();
         this._mapviewer = mapViewer;
         mouseEnabled = false;
         mouseChildren = false;
         if(!glowFilter)
         {
            glowFilter = new GlowFilter(XmlConfig.getInstance().getEntry("colors.text.glow"),1,4,4,6,3);
         }
         if(!cssUri)
         {
            cssUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
         }
         this.addNumberIconsLabel();
      }
      
      private static function compareIconsPriority(pIconA:MapIconElement, pIconB:MapIconElement) : int
      {
         if(pIconA.priority < pIconB.priority)
         {
            return -1;
         }
         if(pIconA.priority > pIconB.priority)
         {
            return 1;
         }
         return 0;
      }
      
      public function get opened() : Boolean
      {
         return this._open;
      }
      
      public function open(pTweenTime:Number = NaN) : void
      {
         var icon:MapIconElement = null;
         var sens:int = 0;
         var inc:int = 0;
         var destRot:Number = NaN;
         var destX:Number = NaN;
         var destY:Number = NaN;
         if(!this._icons || !this._icons.length || !this._iconsNumberLabel)
         {
            return;
         }
         var iconCount:int = parseInt(this._iconsNumberLabel.text);
         this._iconsNumberLabel.visible = false;
         var center:PoolablePoint = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
         var tweenTime:Number = !!isNaN(pTweenTime) ? Number(Math.min(0.1 * iconCount,0.5)) : Number(pTweenTime);
         if(!this._shape)
         {
            this._shape = new Shape();
         }
         else
         {
            this._shape.graphics.clear();
         }
         this._shape.graphics.beginFill(16777215,0);
         this._shape.graphics.drawCircle(center.x,center.y,40);
         PoolsManager.getInstance().getPointPool().checkIn(center);
         super.addChildAt(this._shape,0);
         this.killAllTween();
         this._tween.push(new TweenMax(this._shape,tweenTime,{
            "alpha":1,
            "onCompleteListener":this.openingEnd
         }));
         var offset:Number = Math.PI / 2 + Math.PI / 4;
         var j:int = iconCount;
         for(var i:int = this._icons.length - 1; i >= 0; i--)
         {
            icon = this._icons[i];
            if(icon.visible != false)
            {
               j--;
               offset = iconCount % 2 == 0 ? Number(30) : Number(0);
               sens = j % 2 == 0 ? 1 : -1;
               inc = (j + 1) / 2;
               destRot = offset + sens * inc * 60;
               destX = Math.sin(destRot * Math.PI / 180) * 30 / this._mapviewer.zoomFactor;
               destY = -Math.cos(destRot * Math.PI / 180) * 30 / this._mapviewer.zoomFactor;
               this._tween.push(new TweenMax(icon,tweenTime,{
                  "textureX":destX,
                  "textureY":destY
               }));
            }
         }
      }
      
      private function openingEnd(e:TweenEvent) : void
      {
         this._open = true;
      }
      
      public function close() : void
      {
         var icon:Object = null;
         if(this._iconsNumberLabel)
         {
            this._iconsNumberLabel.visible = true;
         }
         this.killAllTween();
         if(this._shape)
         {
            this._tween.push(new TweenMax(this._shape,0.2,{
               "alpha":0,
               "onCompleteListener":this.shapeTweenFinished
            }));
         }
         for each(icon in this._initialPos)
         {
            this._tween.push(new TweenMax(icon.icon,0.2,{
               "textureX":icon.textureX,
               "textureY":icon.textureY
            }));
         }
         this._open = false;
      }
      
      public function addElement(element:MapIconElement) : void
      {
         this._icons.push(element);
         element.group = this;
         this._initialPos.push({
            "icon":element,
            "textureX":element.textureX,
            "textureY":element.textureY
         });
      }
      
      public function removeElement(element:MapIconElement) : void
      {
         var icon:Object = null;
         this._icons.splice(this._icons.indexOf(element),1);
         var index:Number = 0;
         for each(icon in this._initialPos)
         {
            if(icon.icon == element)
            {
               this._initialPos.splice(index,1);
               break;
            }
            index++;
         }
      }
      
      public function remove() : void
      {
         while(numChildren)
         {
            removeChildAt(0);
         }
         this._icons = null;
         this.killAllTween();
      }
      
      public function display() : void
      {
         var i:int = 0;
         var iconIndex:uint = 0;
         var pos:int = 0;
         this._icons.sort(compareIconsPriority);
         var numIcons:uint = this._icons.length;
         var numVisibleIcons:uint = 0;
         var visibleIconsCount:uint = numIcons > 2 ? uint(2) : uint(numIcons);
         for(i = numIcons - 1; i >= 0; i--)
         {
            if(this._icons[i].uri && this._icons[i].visible)
            {
               numVisibleIcons++;
            }
            iconIndex = Math.min(visibleIconsCount,i);
            pos = -4 * iconIndex;
            this._icons[i].setTextureParent(this);
            this._icons[i].setTexturePosition(0,pos);
         }
         this.updateIconsNumber(numVisibleIcons);
      }
      
      public function setIconVisibility(icon:MapIconElement, visible:Boolean) : void
      {
         var iconElem:MapIconElement = null;
         var index:int = this._icons.indexOf(icon);
         if(index == -1)
         {
            return;
         }
         var isVisible:Boolean = false;
         var numVisibleIcons:int = 0;
         this._icons[index].visible = visible;
         for each(iconElem in this._icons)
         {
            if(iconElem.visible == true)
            {
               isVisible = true;
               if(iconElem.uri)
               {
                  numVisibleIcons++;
               }
            }
         }
         this.visible = isVisible;
         this.updateIconsNumber(numVisibleIcons);
      }
      
      private function updateIconsNumber(pNumIcons:uint) : void
      {
         if(pNumIcons > 1)
         {
            if(!this._iconsNumberLabel)
            {
               this.addNumberIconsLabel();
            }
            if(pNumIcons.toString() != this._iconsNumberLabel.text)
            {
               this._iconsNumberLabel.text = pNumIcons.toString();
               this._iconsNumberLabel.filters = [glowFilter];
               setChildIndex(this._iconsNumberLabel,numChildren - 1);
            }
         }
         else
         {
            this.removeNumberIconsLabel();
         }
      }
      
      private function addNumberIconsLabel() : void
      {
         this._iconsNumberLabel = new Label();
         this._iconsNumberLabel.width = 30;
         this._iconsNumberLabel.height = 20;
         this._iconsNumberLabel.x = -15;
         this._iconsNumberLabel.y = -10;
         this._iconsNumberLabel.css = cssUri;
         addChild(this._iconsNumberLabel);
      }
      
      private function removeNumberIconsLabel() : void
      {
         if(this._iconsNumberLabel)
         {
            this._iconsNumberLabel.filters = null;
            this._iconsNumberLabel.remove();
            this._iconsNumberLabel = null;
         }
      }
      
      private function killAllTween() : void
      {
         var t:TweenMax = null;
         for each(t in this._tween)
         {
            t.kill();
            t.gc = true;
         }
         this._tween = [];
      }
      
      private function shapeTweenFinished(e:TweenEvent) : void
      {
         this._shape.graphics.clear();
      }
      
      public function get icons() : Vector.<MapIconElement>
      {
         return this._icons;
      }
   }
}
