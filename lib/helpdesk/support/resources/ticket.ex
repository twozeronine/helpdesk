defmodule Helpdesk.Support.Ticket do
  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    attribute :subject, :string
  end
end
