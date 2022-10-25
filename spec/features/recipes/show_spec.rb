require 'rails_helper'

RSpec.describe 'recipe show page', type: :feature do 
  describe 'as a visitor' do 
    describe 'when i visit /recipes/:id' do 
      it 'i see the recipe and its attributes, a list of its ingredients names' do 
        cheese = Ingredient.create!(name: "Cheese", cost: 3)
        salami = Ingredient.create!(name: "Salami", cost: 5)
        broccoli = Ingredient.create!(name: "Broccoli", cost: 4)
        pizza = Recipe.create!(name: "Pizza", complexity: 4, genre: "Italian")
        RecipeIngredient.create!(ingredient: cheese, recipe: pizza)
        RecipeIngredient.create!(ingredient: salami, recipe: pizza)

        new_recipe_id = Recipe.last.id 
        visit "/recipes/#{pizza.id}"
        expect(page).to have_content("Recipe Name: #{pizza.name}")
        expect(page).to have_content("Complexity: #{pizza.complexity}")
        expect(page).to have_content("Genre: #{pizza.genre}")
        expect(page).to have_content("Cheese")
        expect(page).to have_content(salami.name)
        expect(page).to_not have_content(broccoli.name)



      end

      it 'i see the total cost of all ingredients in recipe' do 
        cheese = Ingredient.create!(name: "Cheese", cost: 3)
        salami = Ingredient.create!(name: "Salami", cost: 5)
        broccoli = Ingredient.create!(name: "Broccoli", cost: 4)
        pizza = Recipe.create!(name: "Pizza", complexity: 4, genre: "Italian")
        RecipeIngredient.create!(ingredient: cheese, recipe: pizza)
        RecipeIngredient.create!(ingredient: salami, recipe: pizza)

        new_recipe_id = Recipe.last.id 
        visit "/recipes/#{pizza.id}"

        expect(page).to have_content(8)

      end

      it 'i can add an ingredient to a recipe' do 
        cheese = Ingredient.create!(name: "Cheese", cost: 3)
        salami = Ingredient.create!(name: "Salami", cost: 5)
        broccoli = Ingredient.create!(name: "Broccoli", cost: 4)
        pizza = Recipe.create!(name: "Pizza", complexity: 4, genre: "Italian")
        # RecipeIngredient.create!(ingredient: cheese, recipe: pizza)
        # RecipeIngredient.create!(ingredient: salami, recipe: pizza)

        new_recipe_id = Recipe.last.id 
        visit "/recipes/#{pizza.id}"
        fill_in :ingredient_id, with: "#{broccoli.id}"

        click_button "Submit"
      
        expect(page).to have_content("Broccoli")


      end
    end
  end
end