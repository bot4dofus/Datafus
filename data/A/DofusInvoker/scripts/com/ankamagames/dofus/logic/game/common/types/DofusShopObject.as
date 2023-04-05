package com.ankamagames.dofus.logic.game.common.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class DofusShopObject implements IDataCenter
   {
       
      
      protected var _id:int = 0;
      
      protected var _name:String;
      
      protected var _description:String;
      
      public function DofusShopObject(data:Object)
      {
         super();
         if(data)
         {
            this.init(data);
         }
      }
      
      public function init(data:Object) : void
      {
         if(data.hasOwnProperty("id"))
         {
            this._id = data.id;
         }
         this._name = data.name;
         this._description = data.description;
         if(this._description)
         {
            this._description = this._description.replace(/\s*<li>/ig,"<li>");
            this._description = this._description.replace(/(\s*<.l>\s*)|(\s*<\/.l>\s*)/ig,"\n");
            this._description = this._description.replace(/\r\n/gi,"\n").replace(/\n\n/gi,"\n");
         }
      }
      
      public function free() : void
      {
         this._id = 0;
         this._name = null;
         this._description = null;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(desc:String) : void
      {
         this._description = desc;
      }
      
      public function set name(name:String) : void
      {
         this._name = name;
      }
   }
}
