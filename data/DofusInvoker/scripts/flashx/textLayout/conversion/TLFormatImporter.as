package flashx.textLayout.conversion
{
   [ExcludeClass]
   public class TLFormatImporter implements IFormatImporter
   {
       
      
      private var _classType:Class;
      
      private var _description:Object;
      
      private var _rslt:Object;
      
      public function TLFormatImporter(classType:Class, description:Object)
      {
         super();
         this._classType = classType;
         this._description = description;
      }
      
      public function get classType() : Class
      {
         return this._classType;
      }
      
      public function reset() : void
      {
         this._rslt = null;
      }
      
      public function get result() : Object
      {
         return this._rslt;
      }
      
      public function importOneFormat(key:String, val:String) : Boolean
      {
         if(this._description.hasOwnProperty(key))
         {
            if(this._rslt == null)
            {
               this._rslt = new this._classType();
            }
            this._rslt[key] = this._description[key].setHelper(undefined,val);
            return true;
         }
         return false;
      }
   }
}
