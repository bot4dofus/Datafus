package com.ankamagames.dofus.modules.utils.pathfinding.world
{
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   
   public class Node
   {
       
      
      public var parent:Node;
      
      public var vertex:Vertex;
      
      public var map:MapPosition;
      
      public var cost:int;
      
      public var heuristic:int;
      
      public function Node(vertex:Vertex, map:MapPosition, cost:int = 0, heuristic:int = 0, parent:Node = null)
      {
         super();
         this.parent = parent;
         this.cost = cost;
         this.heuristic = heuristic;
         this.map = map;
         this.vertex = vertex;
      }
   }
}
