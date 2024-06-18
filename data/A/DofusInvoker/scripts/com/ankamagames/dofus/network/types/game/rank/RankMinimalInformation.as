package com.ankamagames.dofus.network.types.game.rank
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class RankMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1831;
       
      
      public var id:uint = 0;
      
      public var name:String = "";
      
      public function RankMinimalInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1831;
      }
      
      public function initRankMinimalInformation(id:uint = 0, name:String = "") : RankMinimalInformation
      {
         this.id = id;
         this.name = name;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.name = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RankMinimalInformation(output);
      }
      
      public function serializeAs_RankMinimalInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         output.writeUTF(this.name);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RankMinimalInformation(input);
      }
      
      public function deserializeAs_RankMinimalInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._nameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RankMinimalInformation(tree);
      }
      
      public function deserializeAsyncAs_RankMinimalInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._nameFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of RankMinimalInformation.id.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
