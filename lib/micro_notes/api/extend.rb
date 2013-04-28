class MicroNotes < Grape::API

  namespace :test do
    desc "test"
    get "/" do
      "test ok"
    end
  end

end
