package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.AbstractCharacterInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterRemodelingInformation extends AbstractCharacterInformation implements INetworkType
   {
      
      public static const protocolId:uint = 5105;
       
      
      public var name:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var cosmeticId:uint = 0;
      
      public var colors:Vector.<int>;
      
      private var _colorstree:FuncTree;
      
      public function CharacterRemodelingInformation()
      {
         this.colors = new Vector.<int>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5105;
      }
      
      public function initCharacterRemodelingInformation(id:Number = 0, name:String = "", breed:int = 0, sex:Boolean = false, cosmeticId:uint = 0, colors:Vector.<int> = null) : CharacterRemodelingInformation
      {
         super.initAbstractCharacterInformation(id);
         this.name = name;
         this.breed = breed;
         this.sex = sex;
         this.cosmeticId = cosmeticId;
         this.colors = colors;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.name = "";
         this.breed = 0;
         this.sex = false;
         this.cosmeticId = 0;
         this.colors = new Vector.<int>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterRemodelingInformation(output);
      }
      
      public function serializeAs_CharacterRemodelingInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractCharacterInformation(output);
         output.writeUTF(this.name);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element cosmeticId.");
         }
         output.writeVarShort(this.cosmeticId);
         output.writeShort(this.colors.length);
         for(var _i5:uint = 0; _i5 < this.colors.length; _i5++)
         {
            output.writeInt(this.colors[_i5]);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterRemodelingInformation(input);
      }
      
      public function deserializeAs_CharacterRemodelingInformation(input:ICustomDataInput) : void
      {
         var _val5:int = 0;
         super.deserialize(input);
         this._nameFunc(input);
         this._breedFunc(input);
         this._sexFunc(input);
         this._cosmeticIdFunc(input);
         var _colorsLen:uint = input.readUnsignedShort();
         for(var _i5:uint = 0; _i5 < _colorsLen; _i5++)
         {
            _val5 = input.readInt();
            this.colors.push(_val5);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterRemodelingInformation(tree);
      }
      
      public function deserializeAsyncAs_CharacterRemodelingInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._nameFunc);
         tree.addChild(this._breedFunc);
         tree.addChild(this._sexFunc);
         tree.addChild(this._cosmeticIdFunc);
         this._colorstree = tree.addChild(this._colorstreeFunc);
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
      
      private function _breedFunc(input:ICustomDataInput) : void
      {
         this.breed = input.readByte();
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _cosmeticIdFunc(input:ICustomDataInput) : void
      {
         this.cosmeticId = input.readVarUhShort();
         if(this.cosmeticId < 0)
         {
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of CharacterRemodelingInformation.cosmeticId.");
         }
      }
      
      private function _colorstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._colorstree.addChild(this._colorsFunc);
         }
      }
      
      private function _colorsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readInt();
         this.colors.push(_val);
      }
   }
}
