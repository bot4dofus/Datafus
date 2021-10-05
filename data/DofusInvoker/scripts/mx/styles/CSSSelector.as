package mx.styles
{
   import mx.core.mx_internal;
   
   public class CSSSelector
   {
       
      
      private var _ancestor:CSSSelector;
      
      private var _conditions:Array;
      
      private var _subject:String;
      
      public function CSSSelector(subject:String, conditions:Array = null, ancestor:CSSSelector = null)
      {
         super();
         this._subject = subject;
         this._conditions = conditions;
         this._ancestor = ancestor;
      }
      
      public function get ancestor() : CSSSelector
      {
         return this._ancestor;
      }
      
      public function get conditions() : Array
      {
         return this._conditions;
      }
      
      public function get specificity() : int
      {
         var condition:CSSCondition = null;
         var s:int = 0;
         if("*" != this.subject && "global" != this.subject && "" != this.subject)
         {
            s = 1;
         }
         if(this.conditions != null)
         {
            for each(condition in this.conditions)
            {
               s += condition.specificity;
            }
         }
         if(this.ancestor != null)
         {
            s += this.ancestor.specificity;
         }
         return s;
      }
      
      public function get subject() : String
      {
         return this._subject;
      }
      
      public function matchesStyleClient(object:IAdvancedStyleClient) : Boolean
      {
         var parent:IAdvancedStyleClient = null;
         var match:Boolean = false;
         var condition:CSSCondition = null;
         if(this.ancestor)
         {
            if(this.conditions)
            {
               for each(condition in this.conditions)
               {
                  match = condition.matchesStyleClient(object);
                  if(!match)
                  {
                     return false;
                  }
               }
            }
            match = false;
            parent = object.styleParent;
            while(parent != null)
            {
               if(parent.matchesCSSType(this.ancestor.subject) || "*" == this.ancestor.subject)
               {
                  match = this.ancestor.matchesStyleClient(parent);
                  if(match)
                  {
                     break;
                  }
               }
               parent = parent.styleParent;
            }
         }
         else
         {
            if(this.subject == "*" || this.subject == "" || object.matchesCSSType(this.subject))
            {
               match = true;
            }
            if(match && this.conditions != null)
            {
               for each(condition in this.conditions)
               {
                  match = condition.matchesStyleClient(object);
                  if(!match)
                  {
                     return false;
                  }
               }
            }
         }
         return match;
      }
      
      mx_internal function getPseudoCondition() : String
      {
         var condition:CSSCondition = null;
         var result:String = null;
         if(this.conditions)
         {
            for each(condition in this.conditions)
            {
               if(condition.kind == CSSConditionKind.PSEUDO)
               {
                  result = condition.value;
                  break;
               }
            }
         }
         return result;
      }
      
      public function toString() : String
      {
         var s:String = null;
         var condition:CSSCondition = null;
         if(this.ancestor != null)
         {
            s = this.ancestor.toString() + " " + this.subject;
         }
         else
         {
            s = this.subject;
         }
         if(this.conditions != null)
         {
            for each(condition in this.conditions)
            {
               s += condition.toString();
            }
         }
         return s;
      }
   }
}
