package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.dofus.network.enums.PlayableBreedEnum;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CharacterCreationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 324;
       
      
      private var _isInitialized:Boolean = false;
      
      public var name:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var colors:Vector.<int>;
      
      public var cosmeticId:uint = 0;
      
      private var _colorstree:FuncTree;
      
      private var _colorsindex:uint = 0;
      
      public function CharacterCreationRequestMessage()
      {
         this.colors = new Vector.<int>(5,true);
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 324;
      }
      
      public function initCharacterCreationRequestMessage(name:String = "", breed:int = 0, sex:Boolean = false, colors:Vector.<int> = null, cosmeticId:uint = 0) : CharacterCreationRequestMessage
      {
         this.name = name;
         this.breed = breed;
         this.sex = sex;
         this.colors = colors;
         this.cosmeticId = cosmeticId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.name = "";
         this.breed = 0;
         this.sex = false;
         this.colors = new Vector.<int>(5,true);
         this.cosmeticId = 0;
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
         this.serializeAs_CharacterCreationRequestMessage(output);
      }
      
      public function serializeAs_CharacterCreationRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.name);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         for(var _i4:uint = 0; _i4 < 5; _i4++)
         {
            output.writeInt(this.colors[_i4]);
         }
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         output.writeVarShort(this.cosmeticId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCreationRequestMessage(input);
      }
      
      public function deserializeAs_CharacterCreationRequestMessage(input:ICustomDataInput) : void
      {
         this._nameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         for(var _i4:uint = 0; _i4 < 5; _i4++)
         {
            this.colors[_i4] = input.readInt();
         }
         this._cosmeticIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCreationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_CharacterCreationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._nameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         this._colorstree = tree.addChild(this._colorstreeFunc);
         tree.addChild(this._cosmeticIdFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
         if(this.breed < PlayableBreedEnum.Feca || this.breed > PlayableBreedEnum.Forgelance)
         {
            throw new Error("Forbidden value (" + this.breed + ") on element of CharacterCreationRequestMessage.breed.");
         }
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _colorstreeFunc(input:ICustomDataInput) : void
      {
         for(var i:uint = 0; i < 5; i++)
         {
            this._colorstree.addChild(this._colorsFunc);
         }
      }
      
      private function _colorsFunc(input:ICustomDataInput) : void
      {
         this.colors[this._colorsindex] = input.readInt();
         ++this._colorsindex;
      }
      
      private function _cosmeticIdFunc(input:ICustomDataInput) : void
      {
         this.cosmeticId = input.readVarUhShort();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterCreationRequestMessage.cosmeticId.");
         }
      }
   }
}
