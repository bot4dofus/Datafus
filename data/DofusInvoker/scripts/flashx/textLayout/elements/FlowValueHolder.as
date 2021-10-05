package flashx.textLayout.elements
{
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class FlowValueHolder extends TextLayoutFormat
   {
       
      
      private var _privateData:Object;
      
      public function FlowValueHolder(initialValues:FlowValueHolder = null)
      {
         super(initialValues);
         this.initialize(initialValues);
      }
      
      private function initialize(initialValues:FlowValueHolder) : void
      {
         var s:* = null;
         if(initialValues)
         {
            for(s in initialValues.privateData)
            {
               this.setPrivateData(s,initialValues.privateData[s]);
            }
         }
      }
      
      public function get privateData() : Object
      {
         return this._privateData;
      }
      
      public function set privateData(val:Object) : void
      {
         this._privateData = val;
      }
      
      public function getPrivateData(styleProp:String) : *
      {
         return !!this._privateData ? this._privateData[styleProp] : undefined;
      }
      
      public function setPrivateData(styleProp:String, newValue:*) : void
      {
         if(newValue === undefined)
         {
            if(this._privateData)
            {
               delete this._privateData[styleProp];
            }
         }
         else
         {
            if(this._privateData == null)
            {
               this._privateData = {};
            }
            this._privateData[styleProp] = newValue;
         }
      }
   }
}
