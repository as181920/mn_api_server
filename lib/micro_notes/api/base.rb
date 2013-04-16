class MicroNotes < Grape::API
  format :json

  resource "Records" do
    get "/" do
      ["a","b",123,nil,""]
    end

    get "/gem" do
      Note.all.count
    end
    get "/:id" do
      [1]
    end

  end
end
