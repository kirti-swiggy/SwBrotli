Pod::Spec.new do |spec|
  spec.name         = "Brotli"
  spec.version      = "1.1.0"
  spec.summary      = "Brotli compression format"
  spec.description  = <<-DESC
                     Brotli is a generic-purpose lossless compression algorithm that compresses data
                     using a combination of a modern variant of the LZ77 algorithm, Huffman coding
                     and 2nd order context modeling.
                     DESC
  
  spec.homepage     = "https://github.com/google/brotli"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Google"
  
  spec.ios.deployment_target = "12.0"
  
  spec.source       = {
    :git => "https://github.com/google/brotli.git",
    :tag => "v#{spec.version}"
  }
  
  spec.source_files = "c/include/**/*.h",
                     "c/common/*.{h,c}",
                     "c/dec/*.{h,c}",
                     "c/enc/*.{h,c}"
                     
  spec.public_header_files = "c/include/**/*.h"
  
  spec.header_mappings_dir = "c/include"
  
  spec.pod_target_xcconfig = {
    'GCC_PREPROCESSOR_DEFINITIONS' => 'BROTLI_BUILTIN_PREFIX=BrotliBuiltin'
  }
end