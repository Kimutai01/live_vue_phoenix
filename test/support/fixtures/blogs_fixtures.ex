defmodule LiveVuePhoenix.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveVuePhoenix.Blogs` context.
  """

  @doc """
  Generate a blog.
  """
  def blog_fixture(attrs \\ %{}) do
    {:ok, blog} =
      attrs
      |> Enum.into(%{
        subject: "some subject",
        text: "some text"
      })
      |> LiveVuePhoenix.Blogs.create_blog()

    blog
  end
end
