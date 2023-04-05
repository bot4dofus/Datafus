package com.ankamagames.dofus.modules.utils.pathfinding.world
{
   public class Transition
   {
       
      
      private var _type:int;
      
      private var _direction:int;
      
      private var _skillId:int;
      
      private var _criterion:String;
      
      private var _transitionMapId:Number;
      
      private var _cell:int;
      
      private var _id:uint;
      
      public function Transition(type:int, direction:int, skillId:int, criterion:String, transitionMapId:Number, cell:int, id:uint)
      {
         super();
         this._type = type;
         this._direction = direction;
         this._skillId = skillId;
         this._criterion = criterion;
         this._transitionMapId = transitionMapId;
         this._cell = cell;
         this._id = id;
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
      
      public function get skillId() : int
      {
         return this._skillId;
      }
      
      public function get criterion() : String
      {
         return this._criterion;
      }
      
      public function get cell() : int
      {
         return this._cell;
      }
      
      public function get transitionMapId() : Number
      {
         return this._transitionMapId;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function toString() : String
      {
         return "Transition{_type=" + String(this._type) + ",_direction=" + String(this._direction) + ",_skillId=" + String(this._skillId) + ",_criterion=" + String(this._criterion) + ",_transitionMapId=" + String(this._transitionMapId) + ",_cell=" + String(this._cell) + ",_id=" + String(this._id) + "}";
      }
   }
}
