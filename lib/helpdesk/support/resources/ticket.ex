defmodule Helpdesk.Support.Ticket do
 @moduledoc """
  Helpdesk.Support.Ticket
  |> Ash.Changeset.for_create(:open, %{subject: "My mouse won't click!"})
  |> Helpdesk.Support.create!()
 """


 @doc """
    ETS로 데이터레이어가 설정되어있고 간단하게 테스트가 가능하다 !


    require Ash.Query
    for i <- 0..5 do
      ticket =
        Helpdesk.Support.Ticket
        |> Ash.Changeset.for_create(:open, %{subject: "Issue {i}"})
        |> Helpdesk.Support.create!()

      if rem(i, 2) == 0 do
        ticket
        |> Ash.Changeset.for_update(:close)
        |> Helpdesk.Support.update!()
      end
    end

    # Show the tickets where the subject contains "2"
    Helpdesk.Support.Ticket
    |> Ash.Query.filter(contains(subject, "2"))
    |> Helpdesk.Support.read!()

    # Show the tickets that are closed and their subject does not contain "4"
    Helpdesk.Support.Ticket
    |> Ash.Query.filter(status == :closed and not(contains(subject, "4")))
    |> Helpdesk.Support.read!()
"""
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets



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

  relationships do
    belongs_to :representative, Helpdesk.Support.Representative
  end
end
