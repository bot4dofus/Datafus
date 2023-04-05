package com.ankamagames.dofus.logic.game.common.frames
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.messages.ChangeMessage;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class ProtectPishingFrame implements Frame
   {
      
      private static var _passwordHash:String;
      
      private static var _passwordLength:uint;
       
      
      private var _inputBufferRef:Dictionary;
      
      private var _cancelTarget:Dictionary;
      
      public function ProtectPishingFrame()
      {
         this._inputBufferRef = new Dictionary(true);
         this._cancelTarget = new Dictionary(true);
         super();
      }
      
      public static function setPasswordHash(hash:String, len:uint) : void
      {
         _passwordHash = hash;
         _passwordLength = len;
      }
      
      public function pushed() : Boolean
      {
         if(_passwordHash && _passwordLength)
         {
            StageShareManager.stage.addEventListener(Event.CHANGE,this.onChange);
         }
         return _passwordLength != 0;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.CHANGE,this.onChange);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var input:Input = null;
         var commonMod:Object = null;
         switch(true)
         {
            case msg is ChangeMessage:
               input = ChangeMessage(msg).target as Input;
               if(input && this._cancelTarget[input.textfield])
               {
                  this._cancelTarget[Input(ChangeMessage(msg).target).textfield] = false;
                  commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                  commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.popup.warning.password"),[I18n.getUiText("ui.common.ok")]);
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      protected function onChange(e:Event) : void
      {
         var len:uint = 0;
         var upperBuffer:String = null;
         var i:uint = 0;
         var tf:TextField = e.target as TextField;
         if(!tf)
         {
            return;
         }
         if(!this._inputBufferRef[e.target])
         {
            this._inputBufferRef[e.target] = "";
         }
         var inputBuffer:String = this._inputBufferRef[e.target];
         if(inputBuffer.length >= _passwordLength)
         {
            if(tf.text.substring(0,inputBuffer.length) == inputBuffer)
            {
               inputBuffer = tf.text.substring(inputBuffer.length - _passwordLength);
            }
            else if(inputBuffer.substring(0,tf.text.length) == tf.text)
            {
               inputBuffer = inputBuffer.substring(tf.text.length - _passwordLength);
            }
            else
            {
               inputBuffer = tf.text;
            }
         }
         else
         {
            inputBuffer = tf.text;
         }
         if(inputBuffer.length >= _passwordLength)
         {
            len = inputBuffer.length - _passwordLength + 1;
            upperBuffer = inputBuffer.toUpperCase();
            for(i = 0; i < len; i++)
            {
               if(MD5.hash(upperBuffer.substr(i,_passwordLength)) == _passwordHash)
               {
                  tf.text = tf.text.split(inputBuffer.substr(i,_passwordLength)).join("");
                  this._cancelTarget[tf] = true;
                  break;
               }
            }
         }
         inputBuffer = tf.text;
         this._inputBufferRef[e.target] = inputBuffer;
      }
   }
}
