package mx.styles
{
   import mx.utils.StringUtil;
   
   public class CSSCondition
   {
       
      
      private var _kind:String;
      
      private var _value:String;
      
      public function CSSCondition(kind:String, value:String)
      {
         super();
         this._kind = kind;
         this._value = value;
      }
      
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function get specificity() : int
      {
         if(this.kind == CSSConditionKind.ID)
         {
            return 100;
         }
         if(this.kind == CSSConditionKind.CLASS)
         {
            return 10;
         }
         if(this.kind == CSSConditionKind.PSEUDO)
         {
            return 10;
         }
         return 0;
      }
      
      public function get value() : String
      {
         return this._value;
      }
      
      public function matchesStyleClient(object:IAdvancedStyleClient) : Boolean
      {
         var styleName:String = null;
         var index:int = 0;
         var next:int = 0;
         if(this.kind == CSSConditionKind.CLASS)
         {
            styleName = object.styleName as String;
            if(!styleName)
            {
               return false;
            }
            index = styleName.indexOf(this.value);
            while(index != -1)
            {
               next = index + this.value.length;
               if(index == 0 || StringUtil.isWhitespace(styleName.charAt(index - 1)))
               {
                  if(next == styleName.length || StringUtil.isWhitespace(styleName.charAt(next)))
                  {
                     return true;
                  }
               }
               index = styleName.indexOf(this.value,next);
            }
            return false;
         }
         if(this.kind == CSSConditionKind.ID)
         {
            return object.id == this.value;
         }
         if(this.kind == CSSConditionKind.PSEUDO)
         {
            return object.matchesCSSState(this.value);
         }
         return false;
      }
      
      public function toString() : String
      {
         var s:String = null;
         if(this.kind == CSSConditionKind.CLASS)
         {
            s = "." + this.value;
         }
         else if(this.kind == CSSConditionKind.ID)
         {
            s = "#" + this.value;
         }
         else if(this.kind == CSSConditionKind.PSEUDO)
         {
            s = ":" + this.value;
         }
         else
         {
            s = "";
         }
         return s;
      }
   }
}
