defmodule LiveVuePhoenixWeb.BlogLive.Index do
  use LiveVuePhoenixWeb, :live_view

  alias LiveVuePhoenix.Blogs
  alias LiveVuePhoenix.Blogs.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:blogs, Blogs.list_blogs())
     |> assign(:count, 0)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Blog")
    |> assign(:blog, Blogs.get_blog!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Blog")
    |> assign(:blog, %Blog{})
  end

  def handle_event("inc", %{"value" => value} = _params, socket) when is_binary(value) do
    {:noreply, assign(socket, :count, socket.assigns.count + String.to_integer(value))}
  end

  def handle_event("inc", %{"value" => value} = _params, socket) when is_integer(value) do
    {:noreply, assign(socket, :count, socket.assigns.count + value)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Blogs")
    |> assign(:blog, nil)
  end

  @impl true
  def handle_info({LiveVuePhoenixWeb.BlogLive.FormComponent, {:saved, blog}}, socket) do
    {:noreply, stream_insert(socket, :blogs, blog)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    blog = Blogs.get_blog!(id)
    {:ok, _} = Blogs.delete_blog(blog)

    {:noreply, stream_delete(socket, :blogs, blog)}
  end
end
