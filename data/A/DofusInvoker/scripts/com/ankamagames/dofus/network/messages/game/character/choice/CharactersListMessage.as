package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharactersListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8016;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characters:Vector.<CharacterBaseInformations>;
      
      private var _characterstree:FuncTree;
      
      public function CharactersListMessage()
      {
         this.characters = new Vector.<CharacterBaseInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8016;
      }
      
      public function initCharactersListMessage(characters:Vector.<CharacterBaseInformations> = null) : CharactersListMessage
      {
         this.characters = characters;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.characters = new Vector.<CharacterBaseInformations>();
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
         this.serializeAs_CharactersListMessage(output);
      }
      
      public function serializeAs_CharactersListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.characters.length);
         for(var _i1:uint = 0; _i1 < this.characters.length; _i1++)
         {
            output.writeShort((this.characters[_i1] as CharacterBaseInformations).getTypeId());
            (this.characters[_i1] as CharacterBaseInformations).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharactersListMessage(input);
      }
      
      public function deserializeAs_CharactersListMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:CharacterBaseInformations = null;
         var _charactersLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _charactersLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(CharacterBaseInformations,_id1);
            _item1.deserialize(input);
            this.characters.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharactersListMessage(tree);
      }
      
      public function deserializeAsyncAs_CharactersListMessage(tree:FuncTree) : void
      {
         this._characterstree = tree.addChild(this._characterstreeFunc);
      }
      
      private function _characterstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._characterstree.addChild(this._charactersFunc);
         }
      }
      
      private function _charactersFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterBaseInformations = ProtocolTypeManager.getInstance(CharacterBaseInformations,_id);
         _item.deserialize(input);
         this.characters.push(_item);
      }
   }
}
