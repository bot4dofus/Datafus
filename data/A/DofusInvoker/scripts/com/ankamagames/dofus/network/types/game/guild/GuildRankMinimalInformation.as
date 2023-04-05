package com.ankamagames.dofus.network.types.game.guild
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildRankMinimalInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9298;
       
      
      public var id:uint = 0;
      
      public var name:String = "";
      
      public function GuildRankMinimalInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9298;
      }
      
      public function initGuildRankMinimalInformation(id:uint = 0, name:String = "") : GuildRankMinimalInformation
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
         this.serializeAs_GuildRankMinimalInformation(output);
      }
      
      public function serializeAs_GuildRankMinimalInformation(output:ICustomDataOutput) : void
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
         this.deserializeAs_GuildRankMinimalInformation(input);
      }
      
      public function deserializeAs_GuildRankMinimalInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._nameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildRankMinimalInformation(tree);
      }
      
      public function deserializeAsyncAs_GuildRankMinimalInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._nameFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GuildRankMinimalInformation.id.");
         }
      }
      
      private function _nameFunc(input:ICustomDataInput) : void
      {
         this.name = input.readUTF();
      }
   }
}
