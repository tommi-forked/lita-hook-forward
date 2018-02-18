require 'lita'

Lita.load_locales Dir[File.expand_path(
  File.join('..', '..', 'locales', '*.yml'), __FILE__
)]

require 'lita/handlers/hook_forward'
require 'hook_forward_helpers/incoming_payload'
require 'hook_forward_helpers/attachment'
require 'hook_forward_helpers/lita_target'
