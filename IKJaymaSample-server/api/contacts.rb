module IKJayma

  class EmptyBodyException < StandardError; end

  class NotFoundException < StandardError; end

  class Contacts < Grape::API

    format :json

    rescue_from EmptyBodyException do |_e|
      Rack::Response.new([""], 204, "Content-Type" => "application/json")
    end

    rescue_from NotFoundException do |_e|
      Rack::Response.new([""], 404, "Content-Type" => "application/json")
    end

    rescue_from DuplicatedContactException do |_e|
      Rack::Response.new([""], 409, "Content-Type" => "application/json")
    end

    helpers do
      def permitted_params
        declared(params, include_missing: false)
      end
    end

    resource :contacts do
      # POST /contacts
      desc "Create a new contact"
      params do
        requires :name, type: String, desc: "Contact name"
        optional :email, type: String, desc: "Contact mail"
        optional :phone, type: String, desc: "Contact phone number"
      end
      post do
        contact = Contact.new(permitted_params)
        ContactsDb.instance.add(contact)
        header "Location", "/contacts/#{contact.id}"
        contact.to_hash
      end

      # GET /contacts
      desc "Return all the contacts (or just some of them)"
      params do
        optional :name, type: String, desc: "Contact name"
        optional :email, type: String, desc: "Contact mail"
        optional :phone, type: String, desc: "Contact phone number"
      end
      get do
        contacts = ContactsDb.instance.find(permitted_params)
        contacts.map { |contact| contact.to_hash }
      end

      # PUT /contacts/:id
      desc "Update the contact information"
      params do
        requires :id, type: String, desc: "Contact Id"
        requires :name, type: String, desc: "Contact name"
        optional :email, type: String, desc: "Contact mail"
        optional :phone, type: String, desc: "Contact phone number"
      end
      route_param :id do
        put do
          found_contacts =
            ContactsDb.instance.find({:id => permitted_params[:id]})
          if found_contacts.length == 1
            contact = found_contacts[0]
            contact.update!(permitted_params)
            ContactsDb.instance.store!(contact)
            raise EmptyBodyException
          else
            raise NotFoundException
          end
        end
      end

      # GET /contacts/:id
      desc "Retrieves an individual contact"
      params do
        requires :id, type: String, desc: "Contact Id"
      end
      route_param :id do
        get do
          found_contacts =
            ContactsDb.instance.find({:id => permitted_params[:id]})
          if found_contacts.length == 1
            found_contacts[0].to_hash
          else
            raise NotFoundException
          end
        end
      end

      # DELETE /contacts/:id
      desc "Deletes a contact"
      params do
        requires :id, type: String, desc: "Contact Id"
      end
      route_param :id do
        delete do
          ContactsDb.instance.delete!(permitted_params[:id])
          raise EmptyBodyException
        end
      end
    end
  end

end
