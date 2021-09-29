package cmodule.lua_wrapper
{
   const i_AS3_IntValue:int = exportSym("_AS3_IntValue",new CProcTypemap(CTypemap.IntType,[CTypemap.AS3ValType]).createC(AS3_NOP)[0]);
}
