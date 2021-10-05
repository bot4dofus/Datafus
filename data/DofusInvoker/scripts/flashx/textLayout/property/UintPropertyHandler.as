package flashx.textLayout.property
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class UintPropertyHandler extends PropertyHandler
   {
       
      
      public function UintPropertyHandler()
      {
         super();
      }
      
      override public function get customXMLStringHandler() : Boolean
      {
         return true;
      }
      
      override public function toXMLString(val:Object) : String
      {
         var result:String = val.toString(16);
         if(result.length < 6)
         {
            result = "000000".substr(0,6 - result.length) + result;
         }
         return "#" + result;
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         var newRslt:Number = NaN;
         var str:String = null;
         if(newVal is uint)
         {
            return newVal;
         }
         if(newVal is String)
         {
            str = String(newVal);
            if(str.substr(0,1) == "#")
            {
               str = "0x" + str.substr(1,str.length - 1);
            }
            newRslt = str.toLowerCase().substr(0,2) == "0x" ? Number(parseInt(str)) : Number(NaN);
         }
         else
         {
            if(!(newVal is Number || newVal is int))
            {
               return undefined;
            }
            newRslt = Number(newVal);
         }
         if(isNaN(newRslt))
         {
            return undefined;
         }
         if(newRslt < 0 || newRslt > 4294967295)
         {
            return undefined;
         }
         return newRslt;
      }
   }
}
