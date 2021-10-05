package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.display.DisplayObject;
   import flash.ui.Keyboard;
   
   public class PasswordMenu
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _size:int;
      
      private var _changeOrUse:Boolean;
      
      private var _numberList:Array;
      
      private var _index:int;
      
      private var _listPosX:Array;
      
      private var _txList:Array;
      
      private var _lblList:Array;
      
      private var _onCancel:Function;
      
      private var _onConfirm:Function;
      
      private var _onClose:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var grid:Object;
      
      public var btnOk:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btnReset:ButtonContainer;
      
      public var lblInfo:TextArea;
      
      public var btn_help:ButtonContainer;
      
      public var btn0:ButtonContainer;
      
      public var btn1:ButtonContainer;
      
      public var btn2:ButtonContainer;
      
      public var btn3:ButtonContainer;
      
      public var btn4:ButtonContainer;
      
      public var btn5:ButtonContainer;
      
      public var btn6:ButtonContainer;
      
      public var btn7:ButtonContainer;
      
      public var btn8:ButtonContainer;
      
      public var btn9:ButtonContainer;
      
      public var txBtn0:TextureBitmap;
      
      public var txBtn1:TextureBitmap;
      
      public var txBtn2:TextureBitmap;
      
      public var txBtn3:TextureBitmap;
      
      public var txBtn4:TextureBitmap;
      
      public var txBtn5:TextureBitmap;
      
      public var txBtn6:TextureBitmap;
      
      public var txBtn7:TextureBitmap;
      
      public var textBtn0:Label;
      
      public var textBtn1:Label;
      
      public var textBtn2:Label;
      
      public var textBtn3:Label;
      
      public var textBtn4:Label;
      
      public var textBtn5:Label;
      
      public var textBtn6:Label;
      
      public var textBtn7:Label;
      
      public function PasswordMenu()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._size = param.size;
         this._changeOrUse = param.changeOrUse;
         this._onCancel = param.cancelCallBack;
         this._onConfirm = param.confirmCallBack;
         this.lblInfo.wordWrap = true;
         if(this._changeOrUse)
         {
            this.lblInfo.text = this.uiApi.getText("ui.common.lockInfos");
         }
         else
         {
            this.lblInfo.text = this.uiApi.getText("ui.common.unlockInfos");
         }
         this._txList = [this.txBtn0,this.txBtn1,this.txBtn2,this.txBtn3,this.txBtn4,this.txBtn5,this.txBtn6,this.txBtn7];
         this._lblList = [this.textBtn0,this.textBtn1,this.textBtn2,this.textBtn3,this.textBtn4,this.textBtn5,this.textBtn6,this.textBtn7];
         this._listPosX = new Array(8);
         for(var t:int = 0; t < 8; t++)
         {
            this._listPosX[t] = this._txList[t].x - 2;
         }
         this.reset();
         this.bindsApi.enableShortcutKey(Keyboard.SPACE,32,false);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btnOk,"onRelease");
         this.uiApi.addComponentHook(this.btnReset,"onRelease");
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn0,"onRelease");
         this.uiApi.addComponentHook(this.btn1,"onRelease");
         this.uiApi.addComponentHook(this.btn2,"onRelease");
         this.uiApi.addComponentHook(this.btn3,"onRelease");
         this.uiApi.addComponentHook(this.btn4,"onRelease");
         this.uiApi.addComponentHook(this.btn5,"onRelease");
         this.uiApi.addComponentHook(this.btn6,"onRelease");
         this.uiApi.addComponentHook(this.btn7,"onRelease");
         this.uiApi.addComponentHook(this.btn8,"onRelease");
         this.uiApi.addComponentHook(this.btn9,"onRelease");
         this.sysApi.disableWorldInteraction();
         this.sysApi.removeFocus();
      }
      
      public function getCode() : String
      {
         var number:int = 0;
         var code:* = "";
         for(var i:int = 0; i < 8; i++)
         {
            if(i >= this._size)
            {
               code += "_";
            }
            else
            {
               number = this._numberList[i];
               if(number != -1)
               {
                  if(number == 10)
                  {
                     code += "_";
                  }
                  else
                  {
                     code += number;
                  }
               }
               else
               {
                  code += "_";
               }
            }
         }
         return code;
      }
      
      public function unload() : void
      {
         this.bindsApi.enableShortcutKey(Keyboard.SPACE,32,true);
         this.sysApi.enableWorldInteraction();
      }
      
      private function addNumber(number:int) : void
      {
         this._numberList[this._index] = number;
         ++this._index;
         if(this._index >= this._size)
         {
            this._index = 0;
         }
         this.updateNumbers();
      }
      
      private function reset() : void
      {
         this._numberList = new Array(this._size);
         for(var i:int = 0; i < this._size; i++)
         {
            this._numberList[i] = -1;
         }
         this._index = 0;
         this.updateNumbers();
      }
      
      private function updateNumbers() : void
      {
         var number:int = 0;
         var label:Label = null;
         var lbl:Label = null;
         for(var i:int = 0; i < this._size; i++)
         {
            number = this._numberList[i];
            if(number == -1 || number == 10)
            {
               if(i == this._index)
               {
                  label = this._lblList[i];
                  label.visible = true;
                  label.text = "_";
               }
               else
               {
                  this._lblList[i].visible = false;
               }
            }
            else
            {
               lbl = this._lblList[i];
               lbl.visible = true;
               lbl.text = String(this._numberList[i]);
            }
         }
         for(var k:int = i; k < 8; k++)
         {
            this._txList[k].visible = false;
            this._lblList[k].visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(true)
         {
            case target == this.btnReset:
               this.reset();
               return;
            case target == this.btn_close:
               this.uiApi.unloadUi("passwordMenu");
               if(this._onCancel != null)
               {
                  this._onCancel();
               }
               return;
            case target == this.btnOk:
               this.uiApi.unloadUi("passwordMenu");
               this._onConfirm(this._changeOrUse,this.getCode());
               return;
            case target == this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case target == this.btn0:
               this.addNumber(0);
               return;
            case target == this.btn1:
               this.addNumber(1);
               return;
            case target == this.btn2:
               this.addNumber(2);
               return;
            case target == this.btn3:
               this.addNumber(3);
               return;
            case target == this.btn4:
               this.addNumber(4);
               return;
            case target == this.btn5:
               this.addNumber(5);
               return;
            case target == this.btn6:
               this.addNumber(6);
               return;
            case target == this.btn7:
               this.addNumber(7);
               return;
            case target == this.btn8:
               this.addNumber(8);
               return;
            case target == this.btn9:
               this.addNumber(9);
               return;
         }
      }
      
      private function onKeyUp(target:DisplayObject, keyCode:int) : void
      {
         switch(keyCode)
         {
            case Keyboard.SPACE:
               this.addNumber(10);
               return;
            case Keyboard.NUMBER_0:
            case Keyboard.NUMPAD_0:
               this.addNumber(0);
               return;
            case Keyboard.NUMBER_1:
            case Keyboard.NUMPAD_1:
               this.addNumber(1);
               return;
            case Keyboard.NUMBER_2:
            case Keyboard.NUMPAD_2:
               this.addNumber(2);
               return;
            case Keyboard.NUMBER_3:
            case Keyboard.NUMPAD_3:
               this.addNumber(3);
               return;
            case Keyboard.NUMBER_4:
            case Keyboard.NUMPAD_4:
               this.addNumber(4);
               return;
            case Keyboard.NUMBER_5:
            case Keyboard.NUMPAD_5:
               this.addNumber(5);
               return;
            case Keyboard.NUMBER_6:
            case Keyboard.NUMPAD_6:
               this.addNumber(6);
               return;
            case Keyboard.NUMBER_7:
            case Keyboard.NUMPAD_7:
               this.addNumber(7);
               return;
            case Keyboard.NUMBER_8:
            case Keyboard.NUMPAD_8:
               this.addNumber(8);
               return;
            case Keyboard.NUMBER_9:
            case Keyboard.NUMPAD_9:
               this.addNumber(9);
               return;
            default:
               return;
         }
      }
      
      private function onLeaveDialog() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.uiApi.unloadUi("passwordMenu");
               this._onConfirm(this._changeOrUse,this.getCode());
               return true;
            case "closeUi":
               this.uiApi.unloadUi("passwordMenu");
               if(this._onCancel != null)
               {
                  this._onCancel();
               }
               return true;
            default:
               return false;
         }
      }
   }
}
