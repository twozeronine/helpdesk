defmodule Helpdesk.Support.Ticket do
 @moduledoc """
  Helpdesk.Support.Ticket
  |> Ash.Changeset.for_create(:open, %{subject: "My mouse won't click!"})
  |> Helpdesk.Support.create!()
 """

  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]

    create :open do
      accept [:subject]
    end

    update :close do
      accept []

      change set_attribute(:status, :closed)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :subject, :string do
      allow_nil? false
    end

    attribute :status, :atom do
      constraints [one_of: [:open, :closed]]

      default :open

      allow_nil? false
    end
  end
end
