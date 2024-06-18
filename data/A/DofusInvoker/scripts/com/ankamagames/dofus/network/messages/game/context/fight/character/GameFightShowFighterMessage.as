package com.ankamagames.dofus.network.messages.game.context.fight.character
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameFightShowFighterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5747;
       
      
      private var _isInitialized:Boolean = false;
      
      public var informations:GameFightFighterInformations;
      
      private var _informationstree:FuncTree;
      
      public function GameFightShowFighterMessage()
      {
         this.informations = new GameFightFighterInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5747;
      }
      
      public function initGameFightShowFighterMessage(informations:GameFightFighterInformations = null) : GameFightShowFighterMessage
      {
         this.informations = informations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.informations = new GameFightFighterInformations();
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
         this.serializeAs_GameFightShowFighterMessage(output);
      }
      
      public function serializeAs_GameFightShowFighterMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.informations.getTypeId());
         this.informations.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameFightShowFighterMessage(input);
      }
      
      public function deserializeAs_GameFightShowFighterMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameFightFighterInformations,_id1);
         this.informations.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameFightShowFighterMessage(tree);
      }
      
      public function deserializeAsyncAs_GameFightShowFighterMessage(tree:FuncTree) : void
      {
         this._informationstree = tree.addChild(this._informationstreeFunc);
      }
      
      private function _informationstreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(GameFightFighterInformations,_id);
         this.informations.deserializeAsync(this._informationstree);
      }
   }
}
