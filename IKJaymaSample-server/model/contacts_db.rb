require "singleton"

class DuplicatedContactException < StandardError; end

class ContactsDb
  include Singleton

  def initialize
    @contacts = Hash.new(0)
  end

  def add(contact)
    found_contacts = find({:name => contact.name})
    same_name_contacts = found_contacts.select { |found_contact| found_contact.name == contact.name}
    if same_name_contacts.length != 0
      raise DuplicatedContactException
    end

    id = @contacts.length.to_s
    contact.id = id
    @contacts[id] = contact
    contact
  end

  def store!(contact)
    @contacts[contact.id] = contact
  end

  def delete!(id)
    @contacts.delete id
  end

  def find(params)
    @contacts.values.select { | contact | contact.matches?(params) }
  end

end
