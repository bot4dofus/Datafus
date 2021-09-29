package nochump.util.zip
{
   class ZipConstants
   {
      
      static const LOCSIG:uint = 67324752;
      
      static const LOCHDR:uint = 30;
      
      static const LOCVER:uint = 4;
      
      static const LOCNAM:uint = 26;
      
      static const EXTSIG:uint = 134695760;
      
      static const EXTHDR:uint = 16;
      
      static const CENSIG:uint = 33639248;
      
      static const CENHDR:uint = 46;
      
      static const CENVER:uint = 6;
      
      static const CENNAM:uint = 28;
      
      static const CENOFF:uint = 42;
      
      static const ENDSIG:uint = 101010256;
      
      static const ENDHDR:uint = 22;
      
      static const ENDTOT:uint = 10;
      
      static const ENDOFF:uint = 16;
      
      static const STORED:uint = 0;
      
      static const DEFLATED:uint = 8;
       
      
      function ZipConstants()
      {
         super();
      }
   }
}
