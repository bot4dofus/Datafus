package com.ankamagames.dofus.network.types.game.social
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialEmblem implements INetworkType
   {
      
      public static const protocolId:uint = 2676;
       
      
      public var symbolShape:uint = 0;
      
      public var symbolColor:int = 0;
      
      public var backgroundShape:uint = 0;
      
      public var backgroundColor:int = 0;
      
      public function SocialEmblem()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2676;
      }
      
      public function initSocialEmblem(symbolShape:uint = 0, symbolColor:int = 0, backgroundShape:uint = 0, backgroundColor:int = 0) : SocialEmblem
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
         this.serializeAs_SocialEmblem(output);
      }
      
      public function serializeAs_SocialEmblem(output:ICustomDataOutput) : void
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
         this.deserializeAs_SocialEmblem(input);
      }
      
      public function deserializeAs_SocialEmblem(input:ICustomDataInput) : void
      {
         this._symbolShapeFunc(input);
         this._symbolColorFunc(input);
         this._backgroundShapeFunc(input);
         this._backgroundColorFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialEmblem(tree);
      }
      
      public function deserializeAsyncAs_SocialEmblem(tree:FuncTree) : void
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
            throw new Error("Forbidden value (" + this.symbolShape + ") on element of SocialEmblem.symbolShape.");
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
            throw new Error("Forbidden value (" + this.backgroundShape + ") on element of SocialEmblem.backgroundShape.");
         }
      }
      
      private function _backgroundColorFunc(input:ICustomDataInput) : void
      {
         this.backgroundColor = input.readInt();
      }
   }
}
