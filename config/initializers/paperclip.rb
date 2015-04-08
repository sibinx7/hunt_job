require 'paperclip'
Paperclip.options[:content_type_mappings] = { jpg: 'image/jpeg' }
require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end