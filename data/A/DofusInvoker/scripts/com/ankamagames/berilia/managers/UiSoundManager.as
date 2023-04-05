package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
   import com.ankamagames.berilia.types.data.BeriliaUiSound;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import flash.utils.Dictionary;
   
   public class UiSoundManager
   {
      
      private static var _self:UiSoundManager;
       
      
      private var _registeredUi:Dictionary;
      
      private var _registeredUiElement:Dictionary;
      
      public var playSound:Function;
      
      public function UiSoundManager()
      {
         this._registeredUi = new Dictionary();
         this._registeredUiElement = new Dictionary();
         super();
      }
      
      public static function getInstance() : UiSoundManager
      {
         if(!_self)
         {
            _self = new UiSoundManager();
         }
         return _self;
      }
      
      public function registerUi(uiName:String, openFile:String = null, closeFile:String = null) : void
      {
         var uiSound:BeriliaUiSound = this._registeredUi[uiName];
         if(!uiSound)
         {
            uiSound = new BeriliaUiSound();
            uiSound.uiName = uiName;
            uiSound.openFile = openFile;
            uiSound.closeFile = closeFile;
            this._registeredUi[uiName] = uiSound;
         }
         else
         {
            uiSound.openFile = openFile;
            uiSound.closeFile = closeFile;
         }
      }
      
      public function getUi(uiName:String) : BeriliaUiSound
      {
         return this._registeredUi[uiName];
      }
      
      public function registerUiElement(uiName:String, instanceName:String, hookFct:String, file:String) : void
      {
         var uiElementSound:BeriliaUiElementSound = new BeriliaUiElementSound();
         uiElementSound.name = instanceName;
         uiElementSound.file = file;
         uiElementSound.hook = hookFct;
         this._registeredUiElement[uiName + "::" + instanceName + "::" + hookFct] = uiElementSound;
      }
      
      public function getAllSoundUiElement(target:GraphicContainer) : Vector.<BeriliaUiElementSound>
      {
         var elementHash:* = null;
         var result:Vector.<BeriliaUiElementSound> = new Vector.<BeriliaUiElementSound>();
         if(!target.getUi())
         {
            return result;
         }
         var uiName:* = target.getUi().name + "::";
         var uiNameLen:uint = uiName.length;
         for(elementHash in this._registeredUiElement)
         {
            if(elementHash.substr(0,uiNameLen) == uiName && elementHash.substr(uiNameLen,target.name.length) == target.name)
            {
               result.push(this._registeredUiElement[elementHash]);
            }
         }
         return result;
      }
      
      public function fromUiElement(target:GraphicContainer, hookFct:String) : Boolean
      {
         if(!target || !hookFct || !target.getUi())
         {
            return false;
         }
         var sndElem:BeriliaUiElementSound = this._registeredUiElement[target.getUi().name + "::" + target.name + "::" + hookFct];
         if(target.getUi() && sndElem)
         {
            if(this.playSound != null)
            {
               this.playSound(sndElem.file);
            }
            return true;
         }
         return false;
      }
   }
}
