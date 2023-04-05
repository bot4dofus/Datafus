package com.ankamagames.dofus.datacenter.social
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SocialTagsType implements IDataCenter
   {
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function SocialTagsType()
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
   }
}
