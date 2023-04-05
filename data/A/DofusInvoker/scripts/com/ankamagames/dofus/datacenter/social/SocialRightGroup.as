package com.ankamagames.dofus.datacenter.social
{
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SocialRightGroup implements IDataCenter
   {
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      public var rights:Vector.<SocialRight>;
      
      protected var _name:String;
      
      protected var _sortedRightsByOrder:Vector.<SocialRight>;
      
      public function SocialRightGroup()
      {
         super();
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function getSortedRightsByOrder() : Vector.<SocialRight>
      {
         var utilApi:UtilApi = null;
         if(!this._sortedRightsByOrder)
         {
            utilApi = new UtilApi();
            this._sortedRightsByOrder = utilApi.sort(this.rights,"order",true,true);
         }
         return this._sortedRightsByOrder;
      }
   }
}
