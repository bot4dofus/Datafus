package com.ankamagames.dofus.modules.utils.pathfinding.world
{
   public class Edge
   {
       
      
      private var _from:Vertex;
      
      private var _to:Vertex;
      
      private var _transitions:Vector.<Transition>;
      
      public function Edge(from:Vertex, to:Vertex)
      {
         super();
         this._from = from;
         this._to = to;
         this._transitions = new Vector.<Transition>();
      }
      
      public function get from() : Vertex
      {
         return this._from;
      }
      
      public function get to() : Vertex
      {
         return this._to;
      }
      
      public function get transitions() : Vector.<Transition>
      {
         return this._transitions;
      }
      
      public function addTransition(dir:int, type:int, skill:int, criterion:String, transitionMapId:Number, cell:int, id:uint) : void
      {
         this.transitions.push(new Transition(type,dir,skill,criterion,transitionMapId,cell,id));
      }
      
      public function toString() : String
      {
         return "Edge{_from=" + String(this._from) + ",_to=" + String(this._to) + ",_transitions=" + String(this._transitions) + "}";
      }
   }
}
