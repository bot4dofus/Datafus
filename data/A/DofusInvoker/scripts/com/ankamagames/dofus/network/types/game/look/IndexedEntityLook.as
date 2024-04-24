package com.ankamagames.dofus.network.types.game.look
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class IndexedEntityLook implements INetworkType
   {
      
      public static const protocolId:uint = 9998;
       
      
      public var look:EntityLook;
      
      public var index:uint = 0;
      
      private var _looktree:FuncTree;
      
      public function IndexedEntityLook()
      {
         this.look = new EntityLook();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9998;
      }
      
      public function initIndexedEntityLook(look:EntityLook = null, index:uint = 0) : IndexedEntityLook
      {
         this.look = look;
         this.index = index;
         return this;
      }
      
      public function reset() : void
      {
         this.look = new EntityLook();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IndexedEntityLook(output);
      }
      
      public function serializeAs_IndexedEntityLook(output:ICustomDataOutput) : void
      {
         this.look.serializeAs_EntityLook(output);
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element index.");
         }
         output.writeByte(this.index);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IndexedEntityLook(input);
      }
      
      public function deserializeAs_IndexedEntityLook(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserialize(input);
         this._indexFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IndexedEntityLook(tree);
      }
      
      public function deserializeAsyncAs_IndexedEntityLook(tree:FuncTree) : void
      {
         this._looktree = tree.addChild(this._looktreeFunc);
         tree.addChild(this._indexFunc);
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
      
      private function _indexFunc(input:ICustomDataInput) : void
      {
         this.index = input.readByte();
         if(this.index < 0)
         {
            throw new Error("Forbidden value (" + this.index + ") on element of IndexedEntityLook.index.");
         }
      }
   }
}
