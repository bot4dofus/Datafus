package com.ankamagames.dofus.logic.game.roleplay.types
{
   import avmplus.getQualifiedClassName;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class EntityIcon extends Sprite
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityIcon));
      
      private static const MARGIN_TURN_REMAINING_ICON_X:Number = 15;
      
      private static const MARGIN_TURN_REMAINING_ICON_Y:Number = 12;
      
      private static const ICONS_MARGIN:Number = 10;
       
      
      private var _entity:AnimatedCharacter;
      
      private var _icons:Dictionary;
      
      private var _turnRemaining:Dictionary;
      
      private var _scoreValues:Dictionary;
      
      private var _nbIcons:int;
      
      private var _offsets:Dictionary;
      
      public var needUpdate:Boolean;
      
      public var rendering:Boolean;
      
      public var isPickUpAnimation:Boolean = false;
      
      public function EntityIcon(pEntity:AnimatedCharacter)
      {
         super();
         this._entity = pEntity;
         this._icons = new Dictionary(true);
         this._turnRemaining = new Dictionary(true);
         this._scoreValues = new Dictionary(true);
         this._offsets = new Dictionary(true);
         mouseEnabled = mouseChildren = false;
      }
      
      public function get scoreValues() : Dictionary
      {
         return this._scoreValues;
      }
      
      public function get icons() : Dictionary
      {
         return this._icons;
      }
      
      public function updateAllTurnRemainingIcons() : void
      {
         var pIconName:* = null;
         for(pIconName in this._turnRemaining)
         {
            this.updateTurnRemaining(pIconName,parseInt(this._turnRemaining[pIconName].getChildAt(1).text));
         }
      }
      
      public function updateTurnRemaining(pIconName:String, turnRemaining:Number) : void
      {
         if(!this._turnRemaining[pIconName])
         {
            return;
         }
         this._turnRemaining[pIconName].visible = Dofus.getInstance().options.getOption("showTurnsRemaining") && turnRemaining <= 9;
         this._turnRemaining[pIconName].getChildAt(1).text = String(turnRemaining);
      }
      
      public function updateScoreValue(pIconName:String, scoreValue:int) : void
      {
         if(!this._scoreValues[pIconName])
         {
            return;
         }
         this._scoreValues[pIconName].visible = scoreValue >= 0;
         this._scoreValues[pIconName].getChildAt(1).text = String(scoreValue);
      }
      
      public function addIcon(pIconUri:String, pIconName:String, offset:Point = null, turnRemaining:Number = -1, scoreValue:int = -1) : void
      {
         var ctr_turnRemaining:GraphicContainer = null;
         var tx_turnRemaining:Texture = null;
         var tl_turnRemaining:Label = null;
         var ctr_scoreValue:GraphicContainer = null;
         var tx_scoreValue:Texture = null;
         var tl_scoreValue:Label = null;
         this._icons[pIconName] = new Texture();
         this._offsets[pIconName] = offset;
         var icon:Texture = this._icons[pIconName];
         icon.uri = new Uri(pIconUri);
         icon.dispatchMessages = true;
         icon.addEventListener(Event.COMPLETE,this.iconRendered);
         ++this._nbIcons;
         if(turnRemaining > 0)
         {
            ctr_turnRemaining = new GraphicContainer();
            ctr_turnRemaining.borderColor = 16711935;
            tx_turnRemaining = new Texture();
            tx_turnRemaining.uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/icon_grey_round.png"));
            tx_turnRemaining.width = 20;
            tx_turnRemaining.height = 20;
            tl_turnRemaining = new Label();
            tl_turnRemaining.text = String(turnRemaining);
            tl_turnRemaining.width = 20;
            tl_turnRemaining.height = 20;
            tl_turnRemaining.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/small2.css");
            tl_turnRemaining.cssClass = "whitecenter";
            tx_turnRemaining.finalize();
            tl_turnRemaining.finalize();
            ctr_turnRemaining.addChild(tx_turnRemaining);
            ctr_turnRemaining.addChild(tl_turnRemaining);
            this._turnRemaining[pIconName] = ctr_turnRemaining;
            this._turnRemaining[pIconName].visible = Dofus.getInstance().options.getOption("showTurnsRemaining") && turnRemaining <= 9;
            ctr_turnRemaining.finalize();
            ++this._nbIcons;
         }
         if(scoreValue >= 0)
         {
            ctr_scoreValue = new GraphicContainer();
            ctr_scoreValue.borderColor = 16711935;
            tx_scoreValue = new Texture();
            tx_scoreValue.uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/icon_grey_round.png"));
            tx_scoreValue.width = 25;
            tx_scoreValue.height = 25;
            tl_scoreValue = new Label();
            tl_scoreValue.text = String(scoreValue);
            tl_scoreValue.width = 25;
            tl_scoreValue.height = 25;
            tl_scoreValue.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/small2.css");
            tl_scoreValue.cssClass = "whitecenter";
            tl_scoreValue.verticalAlign = "center";
            tx_scoreValue.finalize();
            tl_scoreValue.finalize();
            ctr_scoreValue.addChild(tx_scoreValue);
            ctr_scoreValue.addChild(tl_scoreValue);
            this._scoreValues[pIconName] = ctr_scoreValue;
            this._scoreValues[pIconName].visible = scoreValue >= 0;
            ctr_scoreValue.finalize();
            ++this._nbIcons;
         }
         icon.finalize();
      }
      
      public function removeIcon(pIconName:String) : void
      {
         var ctr_turnRemaining:GraphicContainer = null;
         var ctr_scoreValue:GraphicContainer = null;
         var iconName:* = null;
         var icon:Texture = this._icons[pIconName];
         if(icon)
         {
            if(this._turnRemaining[pIconName])
            {
               if(getChildByName(this._turnRemaining[pIconName].name))
               {
                  removeChild(this._turnRemaining[pIconName]);
               }
               --this._nbIcons;
               delete this._turnRemaining[pIconName];
            }
            if(this._scoreValues[pIconName])
            {
               if(getChildByName(this._scoreValues[pIconName].name))
               {
                  removeChild(this._scoreValues[pIconName]);
               }
               --this._nbIcons;
               delete this._scoreValues[pIconName];
            }
            if(icon.parent == this)
            {
               removeChild(icon);
            }
            delete this._icons[pIconName];
            --this._nbIcons;
            if(numChildren == this._nbIcons)
            {
               for(iconName in this._icons)
               {
                  icon = this._icons[iconName];
                  ctr_turnRemaining = this._turnRemaining[iconName];
                  removeChild(icon);
                  if(ctr_turnRemaining)
                  {
                     removeChild(ctr_turnRemaining);
                  }
                  ctr_scoreValue = this._scoreValues[iconName];
                  if(ctr_scoreValue)
                  {
                     removeChild(ctr_scoreValue);
                  }
               }
               for(iconName in this._icons)
               {
                  icon = this._icons[iconName];
                  icon.x = width == 0 ? Number(icon.width / 2) : Number(width + 5 + icon.width / 2);
                  if(this._offsets[icon.name])
                  {
                     icon.x += this._offsets[icon.name].x;
                     icon.y += this._offsets[icon.name].y;
                  }
                  ctr_turnRemaining = this._turnRemaining[iconName];
                  if(ctr_turnRemaining)
                  {
                     addChild(icon);
                     this.placeTurnRemainingIcon(icon,ctr_turnRemaining);
                     addChild(ctr_turnRemaining);
                  }
                  else
                  {
                     addChild(icon);
                  }
                  ctr_scoreValue = this._scoreValues[iconName];
                  if(ctr_scoreValue)
                  {
                     addChild(icon);
                     this.placeScoreValueIcon(icon,ctr_scoreValue);
                     addChild(ctr_scoreValue);
                  }
                  else
                  {
                     addChild(icon);
                  }
               }
               this.needUpdate = true;
            }
         }
      }
      
      public function hasIcon(pIconName:String) : Boolean
      {
         return this._icons[pIconName];
      }
      
      public function get length() : int
      {
         return this._nbIcons;
      }
      
      public function remove() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function getIconsBounds() : Rectangle
      {
         var iconName:* = null;
         var iconsBounds:Rectangle = null;
         var icon:Texture = null;
         var iconBounds:Rectangle = null;
         var iconMaxX:Number = NaN;
         var iconMaxY:Number = NaN;
         if(this._icons.length <= 0)
         {
            return null;
         }
         var minX:Number = Infinity;
         var minY:Number = Infinity;
         var maxX:Number = -Infinity;
         var maxY:Number = -Infinity;
         for(iconName in this._icons)
         {
            icon = this._icons[iconName];
            if(icon)
            {
               iconBounds = icon.getBounds(this.parent);
               iconMaxX = iconBounds.x + iconBounds.width;
               iconMaxY = iconBounds.y + iconBounds.height;
               if(iconBounds.width > 0 && iconBounds.height > 0)
               {
                  if(iconBounds.x < minX)
                  {
                     minX = iconBounds.x;
                  }
                  if(iconMaxX > maxX)
                  {
                     maxX = iconMaxX;
                  }
                  if(iconBounds.y < minY)
                  {
                     minY = iconBounds.y;
                  }
                  if(iconMaxY > maxY)
                  {
                     maxY = iconMaxY;
                  }
               }
            }
         }
         iconsBounds = new Rectangle();
         iconsBounds.x = minX;
         iconsBounds.y = minY;
         iconsBounds.width = maxX - minX;
         iconsBounds.height = maxY - minY;
         return iconsBounds;
      }
      
      public function place(pRect:IRectangle, baseEntity:TiphonSprite = null, baseIcons:EntityIcon = null) : void
      {
         var localPos:Point = null;
         var iconsBounds:Rectangle = null;
         var selfBounds:Rectangle = null;
         var globalPos:Point = new Point(pRect.x + pRect.width / 2 - width * Atouin.getInstance().currentZoom / 2,pRect.y - 10 * Atouin.getInstance().currentZoom);
         if(!baseEntity)
         {
            if(!this._entity)
            {
               _log.warn("Trying to place an icon above an unknown entity, aborting");
               return;
            }
            if(!this._entity.parent)
            {
               _log.warn("Trying to place an icon above entity " + this._entity.name + " with no parent, aborting");
               return;
            }
            localPos = this._entity.parent.globalToLocal(globalPos);
         }
         else
         {
            if(!baseEntity.parent)
            {
               _log.warn("Trying to place an icon above entity " + baseEntity.name + " with no parent, aborting");
               return;
            }
            localPos = baseEntity.parent.globalToLocal(globalPos);
            if(baseIcons)
            {
               iconsBounds = baseIcons.getIconsBounds();
               selfBounds = this.getIconsBounds();
               if(iconsBounds && selfBounds)
               {
                  if(localPos.y + selfBounds.height > iconsBounds.y - ICONS_MARGIN)
                  {
                     localPos.y = iconsBounds.y - ICONS_MARGIN;
                  }
               }
               else
               {
                  _log.warn("Unable to get icon bounds for the entity " + baseEntity.name);
               }
            }
         }
         if(localPos)
         {
            x = localPos.x;
            y = localPos.y;
         }
      }
      
      private function iconRendered(pEvent:Event) : void
      {
         var offset:Point = null;
         var currentIconName:String = null;
         var iconName:* = null;
         var icon:Texture = pEvent.currentTarget as Texture;
         icon.removeEventListener(Event.COMPLETE,this.iconRendered);
         icon.x = width == 0 ? Number(icon.width / 2) : Number(width + 5 + icon.width / 2);
         for(iconName in this._icons)
         {
            if(this._icons[iconName] == icon)
            {
               currentIconName = iconName;
               offset = this._offsets[iconName];
               break;
            }
         }
         if(offset)
         {
            icon.x += offset.x;
            icon.y += offset.y;
         }
         addChild(icon);
         var ctr_turnRemaining:GraphicContainer = this._turnRemaining[currentIconName];
         if(ctr_turnRemaining)
         {
            this.placeTurnRemainingIcon(icon,ctr_turnRemaining);
            addChild(ctr_turnRemaining);
         }
         var ctr_scoreValue:GraphicContainer = this._scoreValues[currentIconName];
         if(ctr_scoreValue)
         {
            this.placeScoreValueIcon(icon,ctr_scoreValue);
            addChild(ctr_scoreValue);
         }
         this.needUpdate = true;
      }
      
      private function placeTurnRemainingIcon(icon:Texture, ctr_turnRemaining:GraphicContainer) : void
      {
         ctr_turnRemaining.x = icon.x + icon.width / 2 - MARGIN_TURN_REMAINING_ICON_X;
         ctr_turnRemaining.y = icon.y - MARGIN_TURN_REMAINING_ICON_Y;
      }
      
      private function placeScoreValueIcon(icon:Texture, ctr_scoreValue:GraphicContainer) : void
      {
         ctr_scoreValue.x = icon.x + icon.width / 2 - MARGIN_TURN_REMAINING_ICON_X;
         ctr_scoreValue.y = icon.y - MARGIN_TURN_REMAINING_ICON_Y;
      }
   }
}
