package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MultipleComboBoxGrid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class MultipleComboBoxRenderer extends XmlUiGridRenderer
   {
       
      
      public var multiGrid:MultipleComboBoxGrid;
      
      public var mainContainer:GraphicContainer;
      
      public var placeholder:String = null;
      
      private const LEFT_PADDING:Number = 10;
      
      private const RIGHT_PADDING:Number = 40;
      
      private const ICON_HORIZONTAL_PADDING:Number = 2;
      
      private const ICON_VERTICAL_PADDING:Number = 5;
      
      private const ITEM_PADDING:Number = 5;
      
      private const MIN_LABEL_WIDTH:Number = 7;
      
      private const HIDDEN_TEXT:String = "...";
      
      private const LABEL_KEY_PREFIX:String = "lbl_";
      
      private const TEXTURE_KEY_PREFIX:String = "tx_";
      
      private const PLACEHOLDER_KEY:String = "lbl_placeholder";
      
      private var _loadingIconsNb:Number = 0;
      
      private var _labelCssUri:Uri;
      
      private var _cachedElements:Dictionary;
      
      public function MultipleComboBoxRenderer(strParams:String)
      {
         this._labelCssUri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/small2.css");
         this._cachedElements = new Dictionary();
         super(strParams);
      }
      
      private static function sortItems(obj1:Object, obj2:Object) : Number
      {
         var sortValue1:* = undefined;
         var sortValue2:* = undefined;
         if(obj1.hasOwnProperty("order") && obj2.hasOwnProperty("order"))
         {
            sortValue1 = obj1.order;
            sortValue2 = obj2.order;
         }
         else
         {
            sortValue1 = obj1.typeId;
            sortValue2 = obj1.typeId;
         }
         if(sortValue1 > sortValue2)
         {
            return 1;
         }
         if(sortValue2 > sortValue1)
         {
            return -1;
         }
         return 0;
      }
      
      public function initialize() : void
      {
         var label:Label = new Label();
         label.css = this._labelCssUri;
         label.useTooltipExtension = false;
         label.finalize();
         this.mainContainer.addChild(label);
         this._cachedElements[this.PLACEHOLDER_KEY] = label;
      }
      
      override public function update(data:*, index:uint, dispObj:DisplayObject, isSelected:Boolean, subIndex:uint = 0) : void
      {
         if(!(dispObj is UiRootContainer))
         {
            if(!(dispObj is GraphicContainer))
            {
               _log.warn("Can\'t update, " + dispObj.name + " is not a proper component");
               return;
            }
            this.updateContainer();
            return;
         }
         super.update(data,index,dispObj,isSelected,subIndex);
      }
      
      override public function destroy() : void
      {
         var element:GraphicContainer = null;
         for each(element in this._cachedElements)
         {
            element.remove();
         }
         this._cachedElements = null;
         super.destroy();
      }
      
      private function updateContainer() : void
      {
         var element:GraphicContainer = null;
         var value:Object = null;
         var label:Label = null;
         var texture:Texture = null;
         var labelKey:String = null;
         var textureKey:String = null;
         var values:Array = this.multiGrid.selectedValues;
         for each(element in this._cachedElements)
         {
            element.visible = false;
         }
         if(values === null || values.length <= 0)
         {
            this.setElements();
            return;
         }
         values = values.concat();
         values.sort(sortItems);
         var valuesNb:uint = values.length;
         for(var index:uint = 0; index < valuesNb; index++)
         {
            value = values[index];
            label = null;
            texture = null;
            labelKey = this.LABEL_KEY_PREFIX + value.typeId;
            textureKey = this.TEXTURE_KEY_PREFIX + value.typeId;
            if(!(labelKey in this._cachedElements))
            {
               label = new Label();
               label.css = this._labelCssUri;
               label.useTooltipExtension = false;
               label.finalize();
               this.mainContainer.addChild(label);
               this._cachedElements[labelKey] = label;
            }
            else
            {
               label = this._cachedElements[labelKey];
            }
            label.text = index === valuesNb - 1 ? value.label : value.label + ", ";
            label.fullWidth();
            if(value.hasOwnProperty("icon") && value.icon !== null)
            {
               if(!(textureKey in this._cachedElements))
               {
                  texture = new Texture();
                  texture.keepRatio = true;
                  texture.finalize();
                  texture.height = this.mainContainer.height - this.ICON_VERTICAL_PADDING;
                  texture.addEventListener(Event.COMPLETE,this.onIconLoaded);
                  this.mainContainer.addChild(texture);
                  this._cachedElements[textureKey] = texture;
               }
               else
               {
                  texture = this._cachedElements[textureKey];
               }
               if(texture.uri !== value.icon)
               {
                  ++this._loadingIconsNb;
                  texture.uri = value.icon;
               }
            }
         }
         if(this._loadingIconsNb <= 0)
         {
            this.setElements();
         }
      }
      
      private function setElements() : void
      {
         var element:GraphicContainer = null;
         var placeholderLabel:Label = null;
         var parent:DisplayObjectContainer = null;
         var value:Object = null;
         var texture:Texture = null;
         var label:Label = null;
         var offsetX:Number = NaN;
         var values:Array = this.multiGrid.selectedValues.concat();
         for each(element in this._cachedElements)
         {
            element.visible = false;
         }
         placeholderLabel = this._cachedElements[this.PLACEHOLDER_KEY];
         placeholderLabel.visible = true;
         parent = this.mainContainer.parent;
         placeholderLabel.width = parent.width - placeholderLabel.x - this.RIGHT_PADDING;
         if(values === null || values.length <= 0)
         {
            placeholderLabel.text = this.placeholder;
            placeholderLabel.x = this.LEFT_PADDING;
            placeholderLabel.y = parent.y + parent.height / 2 - placeholderLabel.height / 2;
            return;
         }
         placeholderLabel.text = null;
         values.sort(sortItems);
         var previousLabel:Label = null;
         var maxX:Number = parent.width - this.RIGHT_PADDING - this.MIN_LABEL_WIDTH;
         for each(value in values)
         {
            label = null;
            if(value.hasOwnProperty("icon") && value.icon !== null)
            {
               texture = this._cachedElements[this.TEXTURE_KEY_PREFIX + value.typeId];
            }
            else
            {
               texture = null;
            }
            label = this._cachedElements[this.LABEL_KEY_PREFIX + value.typeId];
            offsetX = previousLabel !== null ? Number(previousLabel.x + previousLabel.width + this.ITEM_PADDING) : Number(this.LEFT_PADDING);
            if(texture !== null)
            {
               texture.visible = true;
               texture.x = offsetX;
               texture.y = parent.y + parent.height / 2 - texture.height / 2;
               label.x = texture.x + texture.width + this.ICON_HORIZONTAL_PADDING;
            }
            else
            {
               label.x = offsetX;
            }
            label.visible = true;
            label.y = parent.y + parent.height / 2 - label.height / 2;
            if(label.x + label.width > maxX || texture !== null && texture.x + texture.width > maxX)
            {
               label.width = Math.max(maxX - label.x,this.MIN_LABEL_WIDTH);
               if(label.width <= this.MIN_LABEL_WIDTH && texture !== null)
               {
                  label.text = this.HIDDEN_TEXT;
                  if(texture !== null)
                  {
                     texture.visible = false;
                     label.x = texture.x;
                     label.width = this.MIN_LABEL_WIDTH;
                  }
               }
               return;
            }
            previousLabel = label;
         }
      }
      
      private function onIconLoaded(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onIconLoaded);
         --this._loadingIconsNb;
         if(this._loadingIconsNb > 0)
         {
            return;
         }
         this._loadingIconsNb = 0;
         this.setElements();
      }
   }
}
