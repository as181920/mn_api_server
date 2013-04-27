require "micro_notes/api/extend"

class MicroNotes < Grape::API
  format :json

  get "/" do
    "Welcome to use Micro-Notes platform"
  end

  resources :notes do
    desc "Return all notes"
    get "all" do
      Note.all
    end

    resources ":note_id" do
      desc "Return note info"
      get "/" do
        #Note.where(id: params[:id]).first
        Note.find params[:note_id]
      end

      resources :entries do
        desc "First page of entries for a note"
        get "/" do
          "TODO"
        end

        desc "Return all entries with data for a note"
        get "all" do
          Note.find(params[:note_id]).all_entries_with_data
        end

        desc "find entry with its id"
        get ":entry_id" do
          #Note.find(params[:note_id]).find_entry_with_data("entry_id" => params[:entry_id])
          Entry.find(params[:entry_id]).with_data
        end
      end
    end
  end

end
