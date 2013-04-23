class MicroNotes < Grape::API

  resources :test do
    desc "test"
    get "/" do
      "test ok"
    end
  end

end
