package Ankama_Common.options
{
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class OptionManager
   {
      
      private static var _self:OptionManager;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      private var _options:Array;
      
      private var _indexedOption:Array;
      
      public function OptionManager()
      {
         this._options = new Array();
         this._indexedOption = new Array();
         super();
         if(_self)
         {
            throw new Error("Singleton Error");
         }
      }
      
      public static function getInstance() : OptionManager
      {
         if(!_self)
         {
            _self = new OptionManager();
         }
         return _self;
      }
      
      public function createItem(id:String, name:String, description:String, ui:String = null, childItems:Array = null) : OptionItem
      {
         return new OptionItem(id,name,description,ui,childItems);
      }
      
      public function addItem(item:OptionItem) : void
      {
         if(this._indexedOption[item.id])
         {
            return;
         }
         this._indexedOption[item.id] = item;
         this._options.push(item);
      }
      
      public function reset() : void
      {
         this._options = new Array();
         this._indexedOption = new Array();
      }
      
      public function get items() : Array
      {
         return this._options;
      }
   }
}
