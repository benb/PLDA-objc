{
  "targets": [
    {
      "target_name" : "jansson",
      "type" : "static_library",
      "sources" : [
        "External/jansson/src/dump.c",
        "External/jansson/src/error.c",
        "External/jansson/src/hashtable.c",
        "External/jansson/src/load.c",
        "External/jansson/src/memory.c",
        "External/jansson/src/pack_unpack.c",
        "External/jansson/src/strbuffer.c",
        "External/jansson/src/strconv.c",
        "External/jansson/src/utf.c",
        "External/jansson/src/value.c"
      ],
      "include_dirs" : [ "External/jansson/src", "./" ],
    },

    {
      "target_name" : "podofo",
      "type" : "static_library",
      "sources" : [
        "External/podofo/src/doc/PdfFontFactoryBase14Data.h",
        "External/podofo/src/doc/PdfAcroForm.cpp",
        "External/podofo/src/doc/PdfFontConfigWrapper.cpp",
        "External/podofo/src/doc/PdfMemDocument.cpp",
        "External/podofo/src/doc/PdfAction.cpp",
        "External/podofo/src/doc/PdfFontFactory.cpp",
        "External/podofo/src/doc/PdfNamesTree.cpp",
        "External/podofo/src/doc/PdfAnnotation.cpp",
        "External/podofo/src/doc/PdfFontMetrics.cpp",
        "External/podofo/src/doc/PdfOutlines.cpp",
        "External/podofo/src/doc/PdfCMapEncoding.cpp",
        "External/podofo/src/doc/PdfFontMetricsBase14.cpp",
        "External/podofo/src/doc/PdfPage.cpp",
        "External/podofo/src/doc/PdfContents.cpp",
        "External/podofo/src/doc/PdfFontMetricsFreetype.cpp",
        "External/podofo/src/doc/PdfPagesTree.cpp",
        "External/podofo/src/doc/PdfDestination.cpp",
        "External/podofo/src/doc/PdfFontMetricsObject.cpp",
        "External/podofo/src/doc/PdfPagesTreeCache.cpp",
        "External/podofo/src/doc/PdfDifferenceEncoding.cpp",
        "External/podofo/src/doc/PdfFontSimple.cpp",
        "External/podofo/src/doc/PdfPainter.cpp",
        "External/podofo/src/doc/PdfDocument.cpp",
        "External/podofo/src/doc/PdfFontTTFSubset.cpp",
        "External/podofo/src/doc/PdfPainterMM.cpp",
        "External/podofo/src/doc/PdfElement.cpp",
        "External/podofo/src/doc/PdfFontTrueType.cpp",
        "External/podofo/src/doc/PdfShadingPattern.cpp",
        "External/podofo/src/doc/PdfEncodingObjectFactory.cpp",
        "External/podofo/src/doc/PdfFontType1.cpp",
        "External/podofo/src/doc/PdfSignOutputDevice.cpp",
        "External/podofo/src/doc/PdfExtGState.cpp",
        "External/podofo/src/doc/PdfFontType1Base14.cpp",
        "External/podofo/src/doc/PdfSignatureField.cpp",
        "External/podofo/src/doc/PdfField.cpp",
        "External/podofo/src/doc/PdfFunction.cpp",
        "External/podofo/src/doc/PdfStreamedDocument.cpp",
        "External/podofo/src/doc/PdfFileSpec.cpp",
        "External/podofo/src/doc/PdfHintStream.cpp",
        "External/podofo/src/doc/PdfFont.cpp",
        "External/podofo/src/doc/PdfIdentityEncoding.cpp",
        "External/podofo/src/doc/PdfTable.cpp",
        "External/podofo/src/doc/PdfFontCID.cpp",
        "External/podofo/src/doc/PdfImage.cpp",
        "External/podofo/src/doc/PdfXObject.cpp",
        "External/podofo/src/doc/PdfFontCache.cpp",
        "External/podofo/src/doc/PdfInfo.cpp",
        "External/podofo/src/base/PdfArray.cpp",
        "External/podofo/src/base/PdfFiltersPrivate.cpp",
        "External/podofo/src/base/PdfRect.cpp",
        "External/podofo/src/base/PdfCanvas.cpp",
        "External/podofo/src/base/PdfImmediateWriter.cpp",
        "External/podofo/src/base/PdfRefCountedBuffer.cpp",
        "External/podofo/src/base/PdfColor.cpp",
        "External/podofo/src/base/PdfInputDevice.cpp",
        "External/podofo/src/base/PdfRefCountedInputDevice.cpp",
        "External/podofo/src/base/PdfContentsTokenizer.cpp",
        "External/podofo/src/base/PdfInputStream.cpp",
        "External/podofo/src/base/PdfReference.cpp",
        "External/podofo/src/base/PdfData.cpp",
        "External/podofo/src/base/PdfLocale.cpp",
        "External/podofo/src/base/PdfRijndael.cpp",
        "External/podofo/src/base/PdfDataType.cpp",
        "External/podofo/src/base/PdfMemStream.cpp",
        "External/podofo/src/base/PdfStream.cpp",
        "External/podofo/src/base/PdfDate.cpp",
        "External/podofo/src/base/PdfMemoryManagement.cpp",
        "External/podofo/src/base/PdfString.cpp",
        "External/podofo/src/base/PdfDictionary.cpp",
        "External/podofo/src/base/PdfName.cpp",
        "External/podofo/src/base/PdfTokenizer.cpp",
        "External/podofo/src/base/PdfEncoding.cpp",
        "External/podofo/src/base/PdfObject.cpp",
        "External/podofo/src/base/PdfVariant.cpp",
        "External/podofo/src/base/PdfEncodingFactory.cpp",
        "External/podofo/src/base/PdfObjectStreamParserObject.cpp",
        "External/podofo/src/base/PdfVecObjects.cpp",
        "External/podofo/src/base/PdfEncrypt.cpp",
        "External/podofo/src/base/PdfOutputDevice.cpp",
        "External/podofo/src/base/PdfWriter.cpp",
        "External/podofo/src/base/PdfError.cpp",
        "External/podofo/src/base/PdfOutputStream.cpp",
        "External/podofo/src/base/PdfXRef.cpp",
        "External/podofo/src/base/PdfFileStream.cpp",
        "External/podofo/src/base/PdfParser.cpp",
        "External/podofo/src/base/PdfXRefStream.cpp",
        "External/podofo/src/base/PdfFilter.cpp",
        "External/podofo/src/base/PdfParserObject.cpp",
        "External/podofo/src/base/PdfXRefStreamParserObject.cpp"
      ],
      "include_dirs" :
      [
        "External/freetype/include",
        "External/podofo",
        "External/podofo/src",
        "External/podofo/src/base",
        "External/podofo/src/doc",
        "External/PoDoFo-staticlib/podofo/podofo" ],

      "conditions" : [
        ['OS=="mac"',
        { "cflags_cc!": [ "-fno-exceptions" ],
          "xcode_settings": {
            'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
            'GCC_ENABLE_CPP_RTTI': 'YES',
            'OTHER_CPLUSPLUSFLAGS' : ['-std=c++11','-stdlib=libc++'],
            'MACOSX_DEPLOYMENT_TARGET': '10.7'
          }
        }],
        ['OS=="linux"', {
            "cflags_cc!" : [ "-fno-exceptions", "-fno-rtti" ],
	    "cflags_cc"  : [ "-std=c++0x" ]
        }]
      ],

      "link_settings" : { "libraries" : [ "-lz" ] },
      'defines' : [ 'BUILDING_PODOFO', 'PODOFO_HAVE_FREETYPE', 'DEBUG_PODOFO' ],
      'dependencies' : ['External/freetype/binding.gyp:freetype']
    },

    {
      "target_name" : "plda",

      "cflags_cc!" : [ "-fno-exceptions" ],
      "conditions" : [
        ['OS=="mac"', { "cflags_cc!": [ "-fno-exceptions" ],
          "xcode_settings": {
            'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
            'OTHER_CPLUSPLUSFLAGS' : ['-std=c++11','-stdlib=libc++'],
            'MACOSX_DEPLOYMENT_TARGET': '10.7'
          }
        }],
        ['OS=="linux"', {
            "cflags_cc!": [ "-fno-exceptions", "-fno-rtti" ]
        }]
      ],

      "sources" :
      [
    	"accumulative_model.cc",
    	"cmd_flags.cc",
    	"common.cc",
    	"document.cc",
    	"infer.cc",
    	"model.cc",
    	"sampler.cc"
      ],

      "include_dirs" :
      [
        "freetype/include",
        "External/podofo",
        "External/podofo/src",
        "External/podofo/src/base",
        "External/podofo/src/doc",
        "External/PoDoFo-staticlib/podofo/podofo",
        "External/jansson/src", "./" ],

      "dependencies" : [ "jansson", "podofo" ]
    }
  ]
}
