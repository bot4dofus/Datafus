package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildEmblem implements INetworkType
   {
      
      public static const protocolId:uint = 6191;
       
      
      public var symbolShape:uint = 0;
      
      public var symbolColor:int = 0;
      
      public var backgroundShape:uint = 0;
      
      public var backgroundColor:int = 0;
      
      public function GuildEmblem()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6191;
      }
      
      public function initGuildEmblem(symbolShape:uint = 0, symbolColor:int = 0, backgroundShape:uint = 0, backgroundColor:int = 0) : GuildEmblem
      {
         this.symbolShape = symbolShape;
         this.symbolColor = symbolColor;
         this.backgroundShape = backgroundShape;
         this.backgroundColor = backgroundColor;
         return this;
      }
      
      public function reset() : void
      {
         this.symbolShape = 0;
         this.symbolColor = 0;
         this.backgroundShape = 0;
         this.backgroundColor = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildEmblem(output);
      }
      
      public function serializeAs_GuildEmblem(output:ICustomDataOutput) : void
      {
         if(this.symbolShape < 0)
         {
            throw new Error("Forbidden value (" + this.symbolShape + ") on element symbolShape.");
         }
         output.writeVarShort(this.symbolShape);
         output.writeInt(this.symbolColor);
         if(this.backgroundShape < 0)
         {
            throw new Error("Forbidden value (" + this.backgroundShape + ") on element backgroundShape.");
         }
         output.writeByte(this.backgroundShape);
         output.writeInt(this.backgroundColor);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildEmblem(input);
      }
      
      public function deserializeAs_GuildEmblem(input:ICustomDataInput) : void
      {
         this._symbolShapeFunc(input);
         this._symbolColorFunc(input);
         this._backgroundShapeFunc(input);
         this._backgroundColorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildEmblem(tree);
      }
      
      public function deserializeAsyncAs_GuildEmblem(tree:FuncTree) : void
      {
         tree.addChild(this._symbolShapeFunc);
         tree.addChild(this._symbolColorFunc);
         tree.addChild(this._backgroundShapeFunc);
         tree.addChild(this._backgroundColorFunc);
      }
      
      private function _symbolShapeFunc(input:ICustomDataInput) : void
      {
         this.symbolShape = input.readVarUhShort();
         if(this.symbolShape < 0)
         {
            throw new Error("Forbidden value (" + this.symbolShape + ") on element of GuildEmblem.symbolShape.");
         }
      }
      
      private function _symbolColorFunc(input:ICustomDataInput) : void
      {
         this.symbolColor = input.readInt();
      }
      
      private function _backgroundShapeFunc(input:ICustomDataInput) : void
      {
         this.backgroundShape = input.readByte();
         if(this.backgroundShape < 0)
         {
            throw new Error("Forbidden value (" + this.backgroundShape + ") on element of GuildEmblem.backgroundShape.");
         }
      }
      
      private function _backgroundColorFunc(input:ICustomDataInput) : void
      {
         this.backgroundColor = input.readInt();
      }
   }
}
