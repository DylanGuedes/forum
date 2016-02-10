defmodule Forum.MessengerServer do
  alias Forum.Message
  alias Forum.Repo
  alias Forum.User
  use GenServer

  def handle_call(:pop, _from, [h|t]) do
    %{source_id: source_id, target_id: target_id, content: content} = h;
    source = Repo.get(User, source_id)
    target = Repo.get(User, target_id)
    msg = Message.changeset(%Message{source: source, target: target, content: content})
    case Repo.insert(msg) do
      {:ok, msg} ->
        {:reply, msg, t}

      {:error, changeset} ->
        {:reply, changeset, t}
    end
  end

  def handle_cast({:push, item}, state) do
    {:noreply, [ item | state ] }
  end

  def start_link(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def push(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  def handle_info(_, state) do
    {:noreply, state}
  end

end
