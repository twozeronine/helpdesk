defmodule Helpdesk.Support.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Helpdesk.Support.Ticket
  end
end
