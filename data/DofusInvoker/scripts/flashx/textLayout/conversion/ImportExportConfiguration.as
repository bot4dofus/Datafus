package flashx.textLayout.conversion
{
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class ImportExportConfiguration
   {
       
      
      tlf_internal var flowElementInfoList:Object;
      
      tlf_internal var flowElementClassList:Object;
      
      tlf_internal var classToNameMap:Object;
      
      public var whiteSpaceCollapse:String = "preserve";
      
      public function ImportExportConfiguration()
      {
         this.flowElementInfoList = {};
         this.flowElementClassList = {};
         this.classToNameMap = {};
         super();
      }
      
      public function addIEInfo(name:String, flowClass:Class, parser:Function, exporter:Function) : void
      {
         var info:FlowElementInfo = new FlowElementInfo(flowClass,parser,exporter);
         if(name)
         {
            this.flowElementInfoList[name] = info;
         }
         if(flowClass)
         {
            this.flowElementClassList[info.flowClassName] = info;
         }
         if(name && flowClass)
         {
            this.classToNameMap[info.flowClassName] = name;
         }
      }
      
      public function lookup(name:String) : FlowElementInfo
      {
         return this.flowElementInfoList[name];
      }
      
      public function lookupName(classToMatch:String) : String
      {
         return this.classToNameMap[classToMatch];
      }
      
      public function lookupByClass(classToMatch:String) : FlowElementInfo
      {
         return this.flowElementClassList[classToMatch];
      }
   }
}
