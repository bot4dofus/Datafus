package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class RemodelingInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9177;
       
      
      public var name:String = "";
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var cosmeticId:uint = 0;
      
      public var colors:Vector.<int>;
      
      private var _colorstree:FuncTree;
      
      public function RemodelingInformation()
      {
         this.colors = new Vector.<int>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9177;
      }
      
      public function initRemodelingInformation(name:String = "", breed:int = 0, sex:Boolean = false, cosmeticId:uint = 0, colors:Vector.<int> = null) : RemodelingInformation
      {
         this.name = name;
         this.breed = breed;
         this.sex = sex;
         this.cosmeticId = cosmeticId;
         this.colors = colors;
         return this;
      }
      
      public function reset() : void
      {
         this.name = "";
         this.breed = 0;
         this.sex = false;
         this.cosmeticId = 0;
         this.colors = new Vector.<int>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RemodelingInformation(output);
      }
      
      public function serializeAs_RemodelingInformation(output:ICustomDataOutput) : void
      {
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
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RemodelingInformation(input);
      }
      
      public function deserializeAs_RemodelingInformation(input:ICustomDataInput) : void
      {
         var _val5:int = 0;
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
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RemodelingInformation(tree);
      }
      
      public function deserializeAsyncAs_RemodelingInformation(tree:FuncTree) : void
      {
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
            throw new Error("Forbidden value (" + this.cosmeticId + ") on element of RemodelingInformation.cosmeticId.");
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
