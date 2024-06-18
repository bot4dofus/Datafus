package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameRolePlayShowMultipleActorsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 323;
       
      
      private var _isInitialized:Boolean = false;
      
      public var informationsList:Vector.<GameRolePlayActorInformations>;
      
      private var _informationsListtree:FuncTree;
      
      public function GameRolePlayShowMultipleActorsMessage()
      {
         this.informationsList = new Vector.<GameRolePlayActorInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 323;
      }
      
      public function initGameRolePlayShowMultipleActorsMessage(informationsList:Vector.<GameRolePlayActorInformations> = null) : GameRolePlayShowMultipleActorsMessage
      {
         this.informationsList = informationsList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.informationsList = new Vector.<GameRolePlayActorInformations>();
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
         this.serializeAs_GameRolePlayShowMultipleActorsMessage(output);
      }
      
      public function serializeAs_GameRolePlayShowMultipleActorsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.informationsList.length);
         for(var _i1:uint = 0; _i1 < this.informationsList.length; _i1++)
         {
            output.writeShort((this.informationsList[_i1] as GameRolePlayActorInformations).getTypeId());
            (this.informationsList[_i1] as GameRolePlayActorInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayShowMultipleActorsMessage(input);
      }
      
      public function deserializeAs_GameRolePlayShowMultipleActorsMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:GameRolePlayActorInformations = null;
         var _informationsListLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _informationsListLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id1);
            _item1.deserialize(input);
            this.informationsList.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayShowMultipleActorsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayShowMultipleActorsMessage(tree:FuncTree) : void
      {
         this._informationsListtree = tree.addChild(this._informationsListtreeFunc);
      }
      
      private function _informationsListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._informationsListtree.addChild(this._informationsListFunc);
         }
      }
      
      private function _informationsListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:GameRolePlayActorInformations = ProtocolTypeManager.getInstance(GameRolePlayActorInformations,_id);
         _item.deserialize(input);
         this.informationsList.push(_item);
      }
   }
}
