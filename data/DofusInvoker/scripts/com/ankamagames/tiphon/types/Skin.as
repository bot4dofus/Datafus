package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.data.CensoredContentManager;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.engine.Tiphon;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Skin extends EventDispatcher
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(Skin));
      
      private static var _censoredSkin:Dictionary;
      
      private static var _alternativeSkin:Dictionary = new Dictionary();
      
      public static var skinPartTransformProvider:ISkinPartTransformProvider;
       
      
      private var _ressourceCount:uint = 0;
      
      private var _ressourceLoading:uint = 0;
      
      private var _partToSwl:Dictionary;
      
      private var _skinParts:Array;
      
      private var _skinClass:Array;
      
      private var _aSkinPartOrdered:Array;
      
      private var _validate:Boolean = true;
      
      private var _partTransformData:Dictionary;
      
      private var _transformData:Dictionary;
      
      private var _baseSkins:Dictionary;
      
      public function Skin()
      {
         this._partTransformData = new Dictionary();
         this._transformData = new Dictionary();
         this._baseSkins = new Dictionary();
         super();
         this._partToSwl = new Dictionary();
         this._skinParts = new Array();
         this._skinClass = new Array();
         this._aSkinPartOrdered = new Array();
      }
      
      public static function addAlternativeSkin(gfxId:uint, alternativeGfxId:uint) : void
      {
         if(!_alternativeSkin[gfxId])
         {
            _alternativeSkin[gfxId] = new Array();
         }
         _alternativeSkin[gfxId].push(alternativeGfxId);
      }
      
      public function get skinList() : Array
      {
         return this._aSkinPartOrdered;
      }
      
      public function get complete() : Boolean
      {
         var skinId:uint = 0;
         if(!this._validate)
         {
            return false;
         }
         var isComplete:Boolean = true;
         for each(skinId in this._aSkinPartOrdered)
         {
            isComplete = isComplete && (Tiphon.skinLibrary.isLoaded(skinId) || Tiphon.skinLibrary.hasError(skinId));
         }
         return isComplete;
      }
      
      public function get validate() : Boolean
      {
         return this._validate;
      }
      
      public function set validate(b:Boolean) : void
      {
         this._validate = b;
         if(b && this.complete)
         {
            this.processSkin();
         }
      }
      
      public function reprocess() : void
      {
         this.processSkin();
      }
      
      public function getSwlFromPart(clipName:String) : uint
      {
         return this._partToSwl[clipName];
      }
      
      public function add(gfxId:uint, alternativeSkinIndex:int = -1) : uint
      {
         var oldSkinGfxId:int = -1;
         if(!_censoredSkin)
         {
            _censoredSkin = CensoredContentManager.getInstance().getCensoredIndex(2);
         }
         if(_censoredSkin[gfxId])
         {
            gfxId = _censoredSkin[gfxId];
         }
         if(alternativeSkinIndex != -1 && _alternativeSkin && _alternativeSkin[gfxId] && alternativeSkinIndex < _alternativeSkin[gfxId].length)
         {
            oldSkinGfxId = gfxId;
            gfxId = _alternativeSkin[gfxId][alternativeSkinIndex];
            this._baseSkins[gfxId] = oldSkinGfxId;
         }
         var parts:Array = new Array();
         for(var i:uint = 0; i < this._aSkinPartOrdered.length; i++)
         {
            if(this._aSkinPartOrdered[i] != gfxId && this._aSkinPartOrdered[i] != oldSkinGfxId)
            {
               parts.push(this._aSkinPartOrdered[i]);
            }
         }
         parts.push(gfxId);
         if(this._aSkinPartOrdered.length != parts.length)
         {
            this._aSkinPartOrdered = parts;
            ++this._ressourceLoading;
            Tiphon.skinLibrary.addResource(gfxId,new Uri(TiphonConstants.SWF_SKIN_PATH + gfxId + ".swl"));
            Tiphon.skinLibrary.askResource(gfxId,null,new Callback(this.onResourceLoaded,gfxId),new Callback(this.onResourceLoaded,gfxId));
         }
         else
         {
            this._aSkinPartOrdered = parts;
         }
         return gfxId;
      }
      
      public function getTransformData(clipName:String) : TransformData
      {
         return this._transformData[clipName];
      }
      
      public function getPart(sName:String) : Sprite
      {
         var t:TransformData = this._transformData[sName];
         if(t && t.overrideClip)
         {
            if(t.overrideClip != sName)
            {
               return null;
            }
            sName = t.originalClip;
         }
         var p:Sprite = this._skinParts[sName];
         if(p && !p.parent)
         {
            if(t)
            {
               p.x = t.x;
               p.y = t.y;
               p.scaleX = t.scaleX;
               p.scaleY = t.scaleY;
               p.rotation = t.rotation;
            }
            else
            {
               p.x = 0;
               p.y = 0;
               p.scaleX = 1;
               p.scaleY = 1;
               p.rotation = 0;
            }
            return p;
         }
         if(this._skinClass[sName])
         {
            p = new this._skinClass[sName]();
            if(t && p)
            {
               p.x = t.x;
               p.y = t.y;
               p.scaleX = t.scaleX;
               p.scaleY = t.scaleY;
               p.rotation = t.rotation;
            }
            this._skinParts[sName] = p;
            return p;
         }
         return null;
      }
      
      public function reset() : void
      {
         this._skinParts = new Array();
         this._skinClass = new Array();
         this._aSkinPartOrdered = new Array();
         this._baseSkins = new Dictionary();
      }
      
      public function addTransform(part:String, skinId:uint, data:TransformData) : void
      {
         if(!this._partTransformData[part])
         {
            this._partTransformData[part] = new Dictionary();
         }
         this._partTransformData[part][skinId] = data;
      }
      
      private function onResourceLoaded(gfxId:uint) : void
      {
         ++this._ressourceCount;
         --this._ressourceLoading;
         this.processSkin();
      }
      
      private function processSkin() : void
      {
         var gfxId:uint = 0;
         var lib:Swl = null;
         var classPart:Array = null;
         var className:String = null;
         var part:* = null;
         var skinTransform:Dictionary = null;
         var j:int = 0;
         var td:TransformData = null;
         for(var i:uint = 0; i < this._aSkinPartOrdered.length; i++)
         {
            gfxId = this._aSkinPartOrdered[i];
            lib = Tiphon.skinLibrary.getResourceById(gfxId);
            if(lib)
            {
               classPart = lib.getDefinitions();
               for each(className in classPart)
               {
                  this._skinClass[className] = lib.getDefinition(className);
                  this._partToSwl[className] = gfxId;
                  delete this._skinParts[className];
               }
            }
         }
         if(this.complete)
         {
            this._partTransformData = new Dictionary();
            this._transformData = new Dictionary();
            if(skinPartTransformProvider)
            {
               skinPartTransformProvider.init(this);
               for(part in this._skinClass)
               {
                  if(this._partTransformData[part])
                  {
                     skinTransform = this._partTransformData[part];
                     for(j = this._aSkinPartOrdered.length - 1; j >= -1; j--)
                     {
                        gfxId = j >= 0 ? uint(this._aSkinPartOrdered[j]) : uint(0);
                        if(this._baseSkins[gfxId] && this._baseSkins[gfxId] != gfxId)
                        {
                           gfxId = this._baseSkins[gfxId];
                        }
                        if(skinTransform[gfxId])
                        {
                           td = skinTransform[gfxId];
                           this._transformData[part] = td;
                           if(td.overrideClip)
                           {
                              this._transformData[td.overrideClip] = td;
                           }
                           break;
                        }
                     }
                  }
               }
            }
            dispatchEvent(new Event(Event.COMPLETE));
         }
         else
         {
            dispatchEvent(new Event(ProgressEvent.PROGRESS));
         }
      }
   }
}
