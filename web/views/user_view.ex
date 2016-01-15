defmodule Forum.UserView do
  use Forum.Web, :view
  alias Forum.User

  def abstract(text) do
    {string_abstract, garbage} = String.split_at(text, 70)
    string_abstract
  end

end
