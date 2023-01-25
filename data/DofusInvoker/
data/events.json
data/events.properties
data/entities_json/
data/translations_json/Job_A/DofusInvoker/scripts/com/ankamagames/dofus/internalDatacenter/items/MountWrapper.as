package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.system.LoaderContext;
   import flash.utils.getQualifiedClassName;
   
   public class MountWrapper extends ItemWrapper implements IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(MountWrapper));
      
      private static var _mountUtil:Object = new Object();
      
      private static var _uriLoaderContext:LoaderContext;
       
      
      public var mountId:int;
      
      private var _uri:Uri;
      
      private var _uriPngMode:Uri;
      
      public function MountWrapper()
      {
         super();
      }
      
      public static function create() : MountWrapper
      {
         var effect:EffectInstance = null;
         var mountWrapper:MountWrapper = new MountWrapper();
         _mountUtil = PlayedCharacterManager.getInstance().mount;
         if(_mountUtil)
         {
            mountWrapper.mountId = _mountUtil.modelId;
            mountWrapper.effects = new Vector.<EffectInstance>();
            for each(effect in _mountUtil.effectList)
            {
               mountWrapper.effects.push(effect);
            }
            mountWrapper.level = _mountUtil.level;
         }
         else
         {
            mountWrapper.mountId = 0;
            mountWrapper.effects = new Vector.<EffectInstance>();
            mountWrapper.level = 0;
         }
         mountWrapper.itemSetId = -1;
         return mountWrapper;
      }
      
      override public function get name() : String
      {
         if(!_mountUtil)
         {
            return "";
         }
         return _mountUtil.description;
      }
      
      override public function get description() : String
      {
         if(!_mountUtil)
         {
            return "";
         }
         return I18n.getUiText("ui.mount.description",[_mountUtil.name,_mountUtil.level,_mountUtil.xpRatio]);
      }
      
      override public function get isWeapon() : Boolean
      {
         return false;
      }
      
      override public function get type() : Object
      {
         return {"name":I18n.getUiText("ui.common.ride")};
      }
      
      override public function get iconUri() : Uri
      {
         return this.getIconUri(true);
      }
      
      override public function get fullSizeIconUri() : Uri
      {
         return this.getIconUri(false);
      }
      
      override public function get errorIconUri() : Uri
      {
         return null;
      }
      
      public function get uri() : Uri
      {
         return this._uri;
      }
      
      override public function getIconUri(pngMode:Boolean = true) : Uri
      {
         if(pngMode)
         {
            this._uriPngMode = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".png"));
            return this._uriPngMode;
         }
         if(this._uri)
         {
            return this._uri;
         }
         this._uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/mounts/").concat(this.mountId).concat(".swf"));
         if(!_uriLoaderContext)
         {
            _uriLoaderContext = new LoaderContext();
            AirScanner.allowByteCodeExecution(_uriLoaderContext,true);
         }
         this._uri.loaderContext = _uriLoaderContext;
         return this._uri;
      }
      
      override public function get info1() : String
      {
         return null;
      }
      
      override public function get timer() : int
      {
         return 0;
      }
      
      override public function get active() : Boolean
      {
         return true;
      }
      
      override public function update(position:uint, objectUID:uint, objectGID:uint, quantity:uint, newEffects:Vector.<ObjectEffect>) : void
      {
         var effect:EffectInstance = null;
         _mountUtil = PlayedCharacterManager.getInstance().mount;
         if(_mountUtil)
         {
            this.mountId = _mountUtil.modelId;
            effects = new Vector.<EffectInstance>();
            for each(effect in _mountUtil.effectList)
            {
               effects.push(effect);
            }
            level = _mountUtil.level;
         }
         else
         {
            this.mountId = 0;
            effects = new Vector.<EffectInstance>();
            level = 0;
         }
      }
      
      override public function toString() : String
      {
         return "[MountWrapper#" + this.mountId + "]";
      }
   }
}
