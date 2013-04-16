$:.push "lib", __FILE__

require "bundler/setup"
require "goliath"
require "grape"
require "mn_model"
require "micro_notes/api/base"

include MnModel

class Application < Goliath::API

  def response(env)
    ::MicroNotes.call(env)
  end
end
