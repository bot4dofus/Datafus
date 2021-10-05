package flashx.textLayout.conversion
{
   import flash.utils.getQualifiedClassName;
   
   [ExcludeClass]
   class FlowElementInfo
   {
       
      
      private var _flowClass:Class;
      
      private var _flowClassName:String;
      
      private var _parser:Function;
      
      private var _exporter:Function;
      
      function FlowElementInfo(flowClass:Class, parser:Function, exporter:Function)
      {
         super();
         this._flowClass = flowClass;
         this._parser = parser;
         this._exporter = exporter;
         this._flowClassName = getQualifiedClassName(flowClass);
      }
      
      public function get flowClass() : Class
      {
         return this._flowClass;
      }
      
      public function get flowClassName() : String
      {
         return this._flowClassName;
      }
      
      public function get parser() : Function
      {
         return this._parser;
      }
      
      public function get exporter() : Function
      {
         return this._exporter;
      }
   }
}
