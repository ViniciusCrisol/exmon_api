defmodule ExMonWeb.TrainerPokemonsView do
  use ExMonWeb, :view

  alias ExMon.Trainer.Pokemon

  def render("create.json", %{
        pokemon: %Pokemon{
          id: id,
          name: name,
          types: types,
          weight: weight,
          nickname: nickname,
          trainer_id: trainer_id,
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Pokemon created!",
      pokemon: %{
        id: id,
        name: name,
        types: types,
        weight: weight,
        nickname: nickname,
        trainer_id: trainer_id,
        inserted_at: inserted_at
      }
    }
  end
end
