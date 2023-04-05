package com.ankamagames.dofus.datacenter.popup
{
   import com.ankamagames.dofus.types.enums.AdministrablePopupActionTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PopupButton implements IDataCenter
   {
       
      
      public var id:int;
      
      public var popupId:uint;
      
      public var type:uint;
      
      public var textId:uint;
      
      public var actionType:uint;
      
      public var actionValue:String;
      
      private var _text:String;
      
      private var _formatedActionParams:Array;
      
      public function PopupButton()
      {
         super();
      }
      
      public function get text() : String
      {
         if(!this._text)
         {
            this._text = I18n.getText(this.textId);
         }
         return this._text;
      }
      
      public function get actionName() : String
      {
         if(this.actionType == AdministrablePopupActionTypeEnum.LINK)
         {
            return "";
         }
         var params:Array = this.actionValue.split(":");
         return params[0];
      }
      
      public function get actionParams() : Array
      {
         var param:Object = null;
         var val:String = null;
         if(this.actionType == AdministrablePopupActionTypeEnum.LINK)
         {
            return [];
         }
         if(this._formatedActionParams != null)
         {
            return this._formatedActionParams;
         }
         this._formatedActionParams = [];
         var params:Array = this.actionValue.split(":");
         var tempActionParams:Array = params[1].split("|");
         for each(val in tempActionParams)
         {
            try
            {
               param = JSON.parse(val);
               this._formatedActionParams.push(param);
            }
            catch(e:SyntaxError)
            {
               _formatedActionParams.push(val);
            }
         }
         return this._formatedActionParams;
      }
      
      private function isNumber(val:String) : Boolean
      {
         var matches:Array = val.match(/([0-9]+(\,[0-9]+|\.[0-9]*)?)|(\.[0-9]+)/);
         return matches && matches.indexOf(val) != -1;
      }
   }
}
