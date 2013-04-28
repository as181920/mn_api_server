require "micro_notes/api/extend"

class MicroNotes < Grape::API
  format :json

  get "/" do
    "Welcome to use Micro-Notes platform"
  end

  namespace :notes do
    desc "Return all notes"
    get "/" do
      Note.all
    end

    desc "Return all notes"
    get "all" do
      Note.all
    end

    desc "create a note"
    post "/" do
      Note.create name: params["note"]["name"], description: params["note"]["description"] if params["note"].present?
    end

    namespace ":note_id" do
      desc "Return note info"
      get "/" do
        #Note.where(id: params[:id]).first
        Note.find_by id: params[:note_id]
      end

      desc "Update note info"
      put "/" do
        #note = Note.find params[:note_id]
        #note.update_attributes name: params["note"]["name"], description: params["note"]["description"] if params["note"].present?
        Note.update params[:note_id], name: params["note"]["name"], description: params["note"]["description"] if params["note"].present?
      end

      desc "Delete a note"
      delete "/" do
        Note.destroy params[:note_id]
      end

      namespace :fields do
        desc "all fields of note"
        get "/" do
          Field.where note_id: params[:note_id]
        end
      end

      namespace :entries do
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
