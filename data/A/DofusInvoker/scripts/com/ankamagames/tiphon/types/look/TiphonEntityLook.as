package com.ankamagames.tiphon.types.look
{
   import com.ankamagames.jerakine.interfaces.ISecurizable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.DefaultableColor;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TiphonEntityLook implements EntityLookObserver, ISecurizable
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEntityLook));
       
      
      private var _observers:Dictionary;
      
      private var _locked:Boolean;
      
      private var _boneChangedWhileLocked:Boolean;
      
      private var _skinsChangedWhileLocked:Boolean;
      
      private var _colorsChangedWhileLocked:Boolean;
      
      private var _scalesChangedWhileLocked:Boolean;
      
      private var _subEntitiesChangedWhileLocked:Boolean;
      
      private var _bone:uint;
      
      private var _skins:Vector.<uint>;
      
      private var _colors:Array;
      
      private var _scaleX:Number = 1;
      
      private var _scaleY:Number = 1;
      
      private var _subEntities:Dictionary;
      
      private var _defaultSkin:int = -1;
      
      private var _skinModifier:ISkinModifier;
      
      public function TiphonEntityLook(sLook:String = null)
      {
         super();
         MEMORY_LOG[this] = 1;
         if(sLook)
         {
            fromString(sLook,this);
         }
      }
      
      public static function fromString(str:String, tiphonInstance:TiphonEntityLook = null) : TiphonEntityLook
      {
         return EntityLookParser.fromString(str,EntityLookParser.DEFAULT_NUMBER_BASE,tiphonInstance);
      }
      
      public function get skins() : Vector.<uint>
      {
         return this._skins;
      }
      
      public function set defaultSkin(id:int) : void
      {
         if(this._defaultSkin != -1 && this._skins)
         {
            this._skins.shift();
         }
         if(!this._skins)
         {
            this._skins = new Vector.<uint>(0,false);
         }
         this._defaultSkin = id;
         if(!this._skins.length || this._skins[0] != this._defaultSkin)
         {
            this._skins.unshift(id);
         }
      }
      
      public function get firstSkin() : uint
      {
         if(!this._skins || !this._skins.length)
         {
            return 0;
         }
         if(this._defaultSkin != -1 && this._skins.length > 1)
         {
            return this._skins[1];
         }
         return this._skins[0];
      }
      
      public function get defaultSkin() : int
      {
         return this._defaultSkin;
      }
      
      public function set skinModifier(sm:ISkinModifier) : void
      {
         this._skinModifier = sm;
      }
      
      public function get skinModifier() : ISkinModifier
      {
         return this._skinModifier;
      }
      
      public function getBone() : uint
      {
         return this._bone;
      }
      
      public function setBone(bone:uint) : void
      {
         var elo:* = null;
         if(this._bone == bone)
         {
            return;
         }
         this._bone = bone;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.boneChanged(this);
            }
         }
         else
         {
            this._boneChangedWhileLocked = true;
         }
      }
      
      public function getSkins(byRef:Boolean = false, keepDefaultSkin:Boolean = true) : Vector.<uint>
      {
         if(!this._skins)
         {
            return null;
         }
         if(byRef)
         {
            return this._skins;
         }
         var skinsLength:uint = this._skins.length;
         var offset:uint = 0;
         if(!keepDefaultSkin && this._defaultSkin != -1)
         {
            offset = 1;
         }
         var skinsDeepCopy:Vector.<uint> = new Vector.<uint>(skinsLength - offset,true);
         for(var i:uint = offset; i < skinsLength; i++)
         {
            skinsDeepCopy[i - offset] = this._skins[i];
         }
         return skinsDeepCopy;
      }
      
      public function resetSkins() : void
      {
         var elo:* = null;
         if(!this._skins || this._skins.length == 0)
         {
            return;
         }
         this._skins = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.skinsChanged(this);
            }
         }
         else
         {
            this._skinsChangedWhileLocked = true;
         }
      }
      
      public function addSkin(skin:uint, addInFirstPosition:Boolean = false) : void
      {
         var elo:* = null;
         if(!this._skins)
         {
            this._skins = new Vector.<uint>(0,false);
         }
         if(!addInFirstPosition)
         {
            this._skins.push(skin);
         }
         else
         {
            this._skins.unshift(skin);
         }
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.skinsChanged(this);
            }
         }
         else
         {
            this._skinsChangedWhileLocked = true;
         }
      }
      
      public function removeSkin(skin:uint) : void
      {
         var elo:* = null;
         if(!this._skins)
         {
            return;
         }
         var skinPos:int = this._skins.indexOf(skin);
         if(skinPos == -1)
         {
            return;
         }
         this._skins = this._skins.slice(0,skinPos).concat(this._skins.slice(skinPos + 1));
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.skinsChanged(this);
            }
         }
         else
         {
            this._skinsChangedWhileLocked = true;
         }
      }
      
      public function getColors(byRef:Boolean = false) : Array
      {
         var colorIndex:* = null;
         if(!this._colors)
         {
            return null;
         }
         if(byRef)
         {
            return this._colors;
         }
         var colorsDeepCopy:Array = new Array();
         for(colorIndex in this._colors)
         {
            colorsDeepCopy[uint(colorIndex)] = this._colors[colorIndex];
         }
         return colorsDeepCopy;
      }
      
      public function getColor(index:uint) : DefaultableColor
      {
         var defaultColor:DefaultableColor = null;
         if(!this._colors || !this._colors[index])
         {
            defaultColor = new DefaultableColor();
            defaultColor.isDefault = true;
            return defaultColor;
         }
         return new DefaultableColor(this._colors[index]);
      }
      
      public function hasColor(index:uint) : Boolean
      {
         return this._colors && this._colors[index];
      }
      
      public function resetColor(index:uint) : void
      {
         var elo:* = null;
         if(!this._colors || !this._colors[index])
         {
            return;
         }
         delete this._colors[index];
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.colorsChanged(this);
            }
         }
         else
         {
            this._colorsChangedWhileLocked = true;
         }
      }
      
      public function resetColors() : void
      {
         var elo:* = null;
         if(!this._colors)
         {
            return;
         }
         this._colors = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.colorsChanged(this);
            }
         }
         else
         {
            this._colorsChangedWhileLocked = true;
         }
      }
      
      public function setColor(index:uint, color:uint) : void
      {
         var colorIndex:* = undefined;
         var elo:* = null;
         if(!this._colors)
         {
            this._colors = new Array();
         }
         if(this._colors[index] && this._colors[index] == color)
         {
            return;
         }
         if(color == 0)
         {
            this._colors[index] = 1;
         }
         else
         {
            this._colors[index] = color;
         }
         var sortedIndex:Array = new Array();
         var copy:Array = new Array();
         for(colorIndex in this._colors)
         {
            sortedIndex.push(colorIndex);
            copy[colorIndex] = this._colors[colorIndex];
            delete this._colors[colorIndex];
         }
         sortedIndex.sort(Array.NUMERIC);
         for each(colorIndex in sortedIndex)
         {
            this._colors[colorIndex] = copy[colorIndex];
         }
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.colorsChanged(this);
            }
         }
         else
         {
            this._colorsChangedWhileLocked = true;
         }
      }
      
      public function getScaleX() : Number
      {
         return this._scaleX;
      }
      
      public function setScaleX(value:Number) : void
      {
         var elo:* = null;
         if(this._scaleX == value)
         {
            return;
         }
         this._scaleX = value;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.scalesChanged(this);
            }
         }
         else
         {
            this._scalesChangedWhileLocked = true;
         }
      }
      
      public function getScaleY() : Number
      {
         return this._scaleY;
      }
      
      public function setScaleY(value:Number) : void
      {
         var elo:* = null;
         if(this._scaleY == value)
         {
            return;
         }
         this._scaleY = value;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.scalesChanged(this);
            }
         }
         else
         {
            this._scalesChangedWhileLocked = true;
         }
      }
      
      public function setScales(x:Number, y:Number) : void
      {
         var elo:* = null;
         if(this._scaleX == x && this._scaleY == y)
         {
            return;
         }
         this._scaleX = x;
         this._scaleY = y;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.scalesChanged(this);
            }
         }
         else
         {
            this._scalesChangedWhileLocked = true;
         }
      }
      
      public function getSubEntities(byRef:Boolean = false) : Dictionary
      {
         var subEntityCategory:* = null;
         var category:uint = 0;
         var subEntityIndex:* = null;
         var index:uint = 0;
         if(!this._subEntities)
         {
            return null;
         }
         if(byRef)
         {
            return this._subEntities;
         }
         var subEntitesDeepCopy:Dictionary = new Dictionary(true);
         for(subEntityCategory in this._subEntities)
         {
            category = uint(subEntityCategory);
            if(!subEntitesDeepCopy[category])
            {
               subEntitesDeepCopy[category] = new Array();
            }
            for(subEntityIndex in this._subEntities[subEntityCategory])
            {
               index = uint(subEntityIndex);
               subEntitesDeepCopy[category][index] = this._subEntities[subEntityCategory][subEntityIndex];
            }
         }
         return subEntitesDeepCopy;
      }
      
      public function getSubEntitiesFromCategory(category:uint) : Array
      {
         var subEntityIndex:* = null;
         var index:uint = 0;
         if(!this._subEntities)
         {
            return null;
         }
         var subEntitiesDeepCopy:Array = new Array();
         for(subEntityIndex in this._subEntities[category])
         {
            index = uint(subEntityIndex);
            subEntitiesDeepCopy[index] = this._subEntities[category][subEntityIndex];
         }
         return subEntitiesDeepCopy;
      }
      
      public function getSubEntity(category:uint, index:uint) : TiphonEntityLook
      {
         if(!this._subEntities)
         {
            return null;
         }
         if(!this._subEntities[category])
         {
            return null;
         }
         return this._subEntities[category][index];
      }
      
      public function resetSubEntities() : void
      {
         var subEntityCategory:* = null;
         var subEntityIndex:* = null;
         var subEntity:TiphonEntityLook = null;
         var elo:* = null;
         if(!this._subEntities)
         {
            return;
         }
         for(subEntityCategory in this._subEntities)
         {
            for(subEntityIndex in this._subEntities[subEntityCategory])
            {
               subEntity = this._subEntities[subEntityCategory][subEntityIndex];
               subEntity.removeObserver(this);
            }
         }
         this._subEntities = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function addSubEntity(category:uint, index:uint, subEntity:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._subEntities)
         {
            this._subEntities = new Dictionary();
         }
         if(!this._subEntities[category])
         {
            this._subEntities[category] = new Array();
         }
         subEntity.addObserver(this);
         this._subEntities[category][index] = subEntity;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function removeSubEntity(category:uint, index:uint = 0) : void
      {
         var elo:* = null;
         if(!this._subEntities || !this._subEntities[category] || !this._subEntities[category][index])
         {
            return;
         }
         delete this._subEntities[category][index];
         if(this._subEntities[category].length == 1)
         {
            delete this._subEntities[category];
         }
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function lock() : void
      {
         if(this._locked)
         {
            return;
         }
         this._locked = true;
         this._boneChangedWhileLocked = false;
         this._skinsChangedWhileLocked = false;
         this._colorsChangedWhileLocked = false;
         this._scalesChangedWhileLocked = false;
         this._subEntitiesChangedWhileLocked = false;
      }
      
      public function unlock(silentUnlock:Boolean = false) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            return;
         }
         this._locked = false;
         if(!silentUnlock)
         {
            for(elo in this._observers)
            {
               if(this._boneChangedWhileLocked)
               {
                  elo.boneChanged(this);
                  this._boneChangedWhileLocked = false;
               }
               if(this._skinsChangedWhileLocked)
               {
                  elo.skinsChanged(this);
                  this._skinsChangedWhileLocked = false;
               }
               if(this._colorsChangedWhileLocked)
               {
                  elo.colorsChanged(this);
                  this._colorsChangedWhileLocked = false;
               }
               if(this._scalesChangedWhileLocked)
               {
                  elo.scalesChanged(this);
                  this._scalesChangedWhileLocked = false;
               }
               if(this._subEntitiesChangedWhileLocked)
               {
                  elo.subEntitiesChanged(this);
                  this._subEntitiesChangedWhileLocked = false;
               }
            }
         }
      }
      
      public function addObserver(elo:EntityLookObserver) : void
      {
         if(!this._observers)
         {
            this._observers = new Dictionary(true);
         }
         this._observers[elo] = 1;
      }
      
      public function removeObserver(elo:EntityLookObserver) : void
      {
         if(!this._observers)
         {
            return;
         }
         delete this._observers[elo];
      }
      
      public function toString() : String
      {
         return EntityLookParser.toString(this);
      }
      
      public function equals(el:TiphonEntityLook) : Boolean
      {
         var hasSubentities:Boolean = false;
         var elHasSubentities:Boolean = false;
         var subCat:* = null;
         var skin:uint = 0;
         var colorIndexStr:* = null;
         var colorIndexStr2:* = null;
         var subEntityCatStr:* = null;
         var subEntityCatStr2:* = null;
         var subEntityCatIndexStr:* = null;
         var se:TiphonEntityLook = null;
         var subEntityCatIndexStr2:* = null;
         var se2:TiphonEntityLook = null;
         if(this._bone != el._bone)
         {
            return false;
         }
         if(this._scaleX != el._scaleX)
         {
            return false;
         }
         if(this._scaleY != el._scaleY)
         {
            return false;
         }
         if(this._skins == null && el._skins != null || this._skins != null && el._skins == null)
         {
            return false;
         }
         if(this._skins && el._skins)
         {
            if(this._skins.length != el._skins.length)
            {
               return false;
            }
            for each(skin in this._skins)
            {
               if(el._skins.indexOf(skin) == -1)
               {
                  return false;
               }
            }
         }
         if(this._colors == null && el._colors != null || this._colors != null && el._colors == null)
         {
            return false;
         }
         if(this._colors && el._colors)
         {
            for(colorIndexStr in this._colors)
            {
               if(el._colors[colorIndexStr] != this._colors[colorIndexStr])
               {
                  return false;
               }
            }
            for(colorIndexStr2 in el._colors)
            {
               if(this._colors[colorIndexStr2] != el._colors[colorIndexStr2])
               {
                  return false;
               }
            }
         }
         for(subCat in this._subEntities)
         {
            if(this._subEntities[subCat])
            {
               hasSubentities = true;
               break;
            }
         }
         for(subCat in el._subEntities)
         {
            if(el._subEntities[subCat])
            {
               elHasSubentities = true;
               break;
            }
         }
         if(hasSubentities != elHasSubentities)
         {
            return false;
         }
         if(this._subEntities && el._subEntities)
         {
            for(subEntityCatStr in this._subEntities)
            {
               if(!el._subEntities || el._subEntities[subEntityCatStr] == null)
               {
                  return false;
               }
               for(subEntityCatIndexStr in this._subEntities[subEntityCatStr])
               {
                  se = el._subEntities[subEntityCatStr][subEntityCatIndexStr];
                  if(se == null)
                  {
                     return false;
                  }
                  if(!se.equals(this._subEntities[subEntityCatStr][subEntityCatIndexStr]))
                  {
                     return false;
                  }
               }
            }
            for(subEntityCatStr2 in el._subEntities)
            {
               if(!this._subEntities || this._subEntities[subEntityCatStr2] == null)
               {
                  return false;
               }
               for(subEntityCatIndexStr2 in el._subEntities[subEntityCatStr2])
               {
                  se2 = this._subEntities[subEntityCatStr2][subEntityCatIndexStr2];
                  if(se2 == null)
                  {
                     return false;
                  }
                  if(!se2.equals(el._subEntities[subEntityCatStr2][subEntityCatIndexStr2]))
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      public function updateFrom(el:TiphonEntityLook) : void
      {
         if(this.equals(el))
         {
            return;
         }
         this.lock();
         this.setBone(el.getBone());
         this._colorsChangedWhileLocked = true;
         this._colors = el.getColors();
         var skins:Vector.<uint> = el.getSkins();
         if(!this.equalsToCurrentSkins(skins) || this._defaultSkin != el.defaultSkin)
         {
            this._skinsChangedWhileLocked = true;
            this._skins = skins;
            this._defaultSkin = el.defaultSkin;
         }
         var newSubEntities:Dictionary = el.getSubEntities();
         if(!this.equalsToCurrentSubEntities(newSubEntities))
         {
            this.resetSubEntities();
            this._subEntitiesChangedWhileLocked = true;
            this._subEntities = newSubEntities;
         }
         this.setScales(el.getScaleX(),el.getScaleY());
         this.unlock(false);
      }
      
      public function equalsToCurrentSkins(skins:Vector.<uint>) : Boolean
      {
         var equals:Function = null;
         if(skins && this._skins && skins.length == this._skins.length)
         {
            equals = function(item:uint, index:int, vector:Vector.<uint>):Boolean
            {
               return skins[index] == _skins[index];
            };
            return skins.every(equals);
         }
         return false;
      }
      
      public function equalsToCurrentSubEntities(subentities:Dictionary) : Boolean
      {
         var key:* = null;
         var nbKeys:int = 0;
         if(subentities && this._subEntities)
         {
            for(key in subentities)
            {
               if(subentities[key] != this._subEntities[key])
               {
                  return false;
               }
               nbKeys++;
            }
            for(key in this._subEntities)
            {
               nbKeys--;
            }
            return nbKeys == 0;
         }
         return subentities == this._subEntities;
      }
      
      public function boneChanged(look:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function skinsChanged(look:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function colorsChanged(look:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function scalesChanged(look:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function subEntitiesChanged(look:TiphonEntityLook) : void
      {
         var elo:* = null;
         if(!this._locked)
         {
            for(elo in this._observers)
            {
               elo.subEntitiesChanged(this);
            }
         }
         else
         {
            this._subEntitiesChangedWhileLocked = true;
         }
      }
      
      public function clone() : TiphonEntityLook
      {
         var i:* = null;
         var j:* = null;
         var o:TiphonEntityLook = new TiphonEntityLook();
         o._bone = this._bone;
         o._colors = !!this._colors ? this._colors.concat() : this._colors;
         o._skins = !!this._skins ? this._skins.concat() : this._skins;
         o._defaultSkin = this._defaultSkin;
         o._scaleX = this._scaleX;
         o._scaleY = this._scaleY;
         o._skinModifier = this._skinModifier;
         if(this._subEntities)
         {
            o._subEntities = new Dictionary(true);
            for(i in this._subEntities)
            {
               o._subEntities[i] = [];
               for(j in this._subEntities[i])
               {
                  if(this._subEntities[i][j])
                  {
                     o._subEntities[i][j] = this._subEntities[i][j].clone();
                  }
               }
            }
         }
         return o;
      }
      
      public function getSecureObject() : *
      {
         return this;
      }
   }
}
