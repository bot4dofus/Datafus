package
{
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   
   public class Type
   {
       
      
      public function Type()
      {
      }
      
      public static function getClassName(param1:Class) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:String = _loc2_;
         if(_loc3_ == "Boolean")
         {
            return "Bool";
         }
         if(_loc3_ == "Number")
         {
            return "Float";
         }
         if(_loc3_ == "int")
         {
            return "Int";
         }
         var _loc4_:Array = _loc2_.split("::");
         return _loc4_.join(".");
      }
      
      public static function describe(param1:*, param2:Boolean) : Array
      {
         var _loc8_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:XML = describeType(param1);
         if(param2)
         {
            _loc4_ = _loc4_.factory[0];
         }
         var _loc5_:XMLList = _loc4_.child("method");
         var _loc6_:int = 0;
         var _loc7_:int = _loc5_.length();
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc6_++;
            _loc3_.push(Std.string(_loc5_[_loc8_].attribute("name")));
         }
         var _loc9_:XMLList = _loc4_.child("variable");
         _loc6_ = 0;
         _loc7_ = _loc9_.length();
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc6_++;
            _loc3_.push(Std.string(_loc9_[_loc8_].attribute("name")));
         }
         var _loc10_:XMLList = _loc4_.child("accessor");
         _loc6_ = 0;
         _loc7_ = _loc10_.length();
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc6_++;
            _loc3_.push(Std.string(_loc10_[_loc8_].attribute("name")));
         }
         return _loc3_;
      }
      
      public static function getClassFields(param1:Class) : Array
      {
         var _loc2_:Array = Type.describe(param1,false);
         _loc2_.remove("__construct__");
         _loc2_.remove("prototype");
         return _loc2_;
      }
   }
}
