package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MapObstacleUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 978;
       
      
      private var _isInitialized:Boolean = false;
      
      public var obstacles:Vector.<MapObstacle>;
      
      private var _obstaclestree:FuncTree;
      
      public function MapObstacleUpdateMessage()
      {
         this.obstacles = new Vector.<MapObstacle>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 978;
      }
      
      public function initMapObstacleUpdateMessage(obstacles:Vector.<MapObstacle> = null) : MapObstacleUpdateMessage
      {
         this.obstacles = obstacles;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.obstacles = new Vector.<MapObstacle>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_MapObstacleUpdateMessage(output);
      }
      
      public function serializeAs_MapObstacleUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.obstacles.length);
         for(var _i1:uint = 0; _i1 < this.obstacles.length; _i1++)
         {
            (this.obstacles[_i1] as MapObstacle).serializeAs_MapObstacle(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MapObstacleUpdateMessage(input);
      }
      
      public function deserializeAs_MapObstacleUpdateMessage(input:ICustomDataInput) : void
      {
         var _item1:MapObstacle = null;
         var _obstaclesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _obstaclesLen; _i1++)
         {
            _item1 = new MapObstacle();
            _item1.deserialize(input);
            this.obstacles.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MapObstacleUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_MapObstacleUpdateMessage(tree:FuncTree) : void
      {
         this._obstaclestree = tree.addChild(this._obstaclestreeFunc);
      }
      
      private function _obstaclestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._obstaclestree.addChild(this._obstaclesFunc);
         }
      }
      
      private function _obstaclesFunc(input:ICustomDataInput) : void
      {
         var _item:MapObstacle = new MapObstacle();
         _item.deserialize(input);
         this.obstacles.push(_item);
      }
   }
}
