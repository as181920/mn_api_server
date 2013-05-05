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

    #desc "Return all entries with data for a note"
    #get "all_entries_with_data" do
    #  note = Note.find params[:note_id]
    #  note.all_entries_with_data
    #end

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
        note = Note.find params[:note_id]
        note.update_attributes name: params["note"]["name"], description: params["note"]["description"] if params["note"].present?
        note
        #Note.update params[:note_id], name: params["note"]["name"], description: params["note"]["description"] if params["note"].present?
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

        desc "create a field for note"
        post "/" do
          note = Note.find_by id: params[:note_id]
          field = note.fields.create name: params["field"]["name"]
        end

        namespace ":id" do
          desc "Return field info for a note"
          get "/" do
            Field.find_by id: params[:id]
          end

          desc "Update field info for a note"
          put "/" do
            field = Field.find_by id: params[:id]
            field.update_attributes name: params["field"]["name"]
            field
          end

          desc "Delete field for a note"
          delete "/" do
            Field.destroy params[:id]
          end
        end
      end

      namespace :entries do
        desc "First page of entries for a note"
        get "/" do
          #Entry.where note_id: params[:note_id]
          Note.find(params[:note_id]).all_entries_with_data
        end

        desc "Return all entries with data for a note"
        get "all" do
          Note.find(params[:note_id]).all_entries_with_data
        end

        desc "Return all entries with data for a note"
        get "all_data" do
          Entry.all_data note_id: params[:note_id]
        end


        desc "create entry with data"
        post "create_with_data" do
          note = Note.find params[:note_id]
          #entry.merge!(entry['data']).delete "data"
          #entry = note.entries.create_with_data params["entry"]["data"]
          entry = note.entries.create_with_data params["entry"]["data"]
        end

        namespace ":id" do
          desc "find entry by its id"
          get "/" do
            #Note.find(params[:note_id]).find_entry_with_data("id" => params[:id])
            #Entry.find(params[:id]).with_data
            Entry.find(params[:id])
          end

          desc "find entry by its id with data"
          get "find_with_data" do
            Entry.find(params[:id]).with_data
          end

          desc "update entry with data by its id"
          put "update_with_data" do
            Entry.update_with_data params["entry"]["id"], params["entry"]["data"]
          end
        end
      end
    end
  end

end
