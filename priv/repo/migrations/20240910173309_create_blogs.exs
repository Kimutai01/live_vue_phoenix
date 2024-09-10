defmodule LiveVuePhoenix.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :subject, :string
      add :text, :string

      timestamps(type: :utc_datetime)
    end
  end
end
