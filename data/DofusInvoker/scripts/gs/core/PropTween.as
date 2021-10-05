package gs.core
{
   public final class PropTween
   {
       
      
      public var target:Object;
      
      public var property:String;
      
      public var start:Number;
      
      public var change:Number;
      
      public var name:String;
      
      public var priority:int;
      
      public var isPlugin:Boolean;
      
      public var nextNode:PropTween;
      
      public var prevNode:PropTween;
      
      public function PropTween(target:Object, property:String, start:Number, change:Number, name:String, isPlugin:Boolean, nextNode:PropTween = null, priority:int = 0)
      {
         super();
         this.target = target;
         this.property = property;
         this.start = start;
         this.change = change;
         this.name = name;
         this.isPlugin = isPlugin;
         if(nextNode)
         {
            nextNode.prevNode = this;
            this.nextNode = nextNode;
         }
         this.priority = priority;
      }
   }
}
