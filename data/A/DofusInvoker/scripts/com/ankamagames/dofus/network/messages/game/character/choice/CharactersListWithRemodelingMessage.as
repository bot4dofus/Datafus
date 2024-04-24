package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterToRemodelInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharactersListWithRemodelingMessage extends CharactersListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8096;
       
      
      private var _isInitialized:Boolean = false;
      
      public var charactersToRemodel:Vector.<CharacterToRemodelInformations>;
      
      private var _charactersToRemodeltree:FuncTree;
      
      public function CharactersListWithRemodelingMessage()
      {
         this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8096;
      }
      
      public function initCharactersListWithRemodelingMessage(characters:Vector.<CharacterBaseInformations> = null, charactersToRemodel:Vector.<CharacterToRemodelInformations> = null) : CharactersListWithRemodelingMessage
      {
         super.initCharactersListMessage(characters);
         this.charactersToRemodel = charactersToRemodel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.charactersToRemodel = new Vector.<CharacterToRemodelInformations>();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharactersListWithRemodelingMessage(output);
      }
      
      public function serializeAs_CharactersListWithRemodelingMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CharactersListMessage(output);
         output.writeShort(this.charactersToRemodel.length);
         for(var _i1:uint = 0; _i1 < this.charactersToRemodel.length; _i1++)
         {
            (this.charactersToRemodel[_i1] as CharacterToRemodelInformations).serializeAs_CharacterToRemodelInformations(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharactersListWithRemodelingMessage(input);
      }
      
      public function deserializeAs_CharactersListWithRemodelingMessage(input:ICustomDataInput) : void
      {
         var _item1:CharacterToRemodelInformations = null;
         super.deserialize(input);
         var _charactersToRemodelLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _charactersToRemodelLen; _i1++)
         {
            _item1 = new CharacterToRemodelInformations();
            _item1.deserialize(input);
            this.charactersToRemodel.push(_item1);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharactersListWithRemodelingMessage(tree);
      }
      
      public function deserializeAsyncAs_CharactersListWithRemodelingMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._charactersToRemodeltree = tree.addChild(this._charactersToRemodeltreeFunc);
      }
      
      private function _charactersToRemodeltreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._charactersToRemodeltree.addChild(this._charactersToRemodelFunc);
         }
      }
      
      private function _charactersToRemodelFunc(input:ICustomDataInput) : void
      {
         var _item:CharacterToRemodelInformations = new CharacterToRemodelInformations();
         _item.deserialize(input);
         this.charactersToRemodel.push(_item);
      }
   }
}
