# frozen_string_literal: true

module FitbitAPI
  class Client
    # Retrieves a list of meals created by the user from their food log

    def meals
      get("user/#{user_id}/meals.json")
    end

    # Retrieves a single meal created by the user from their food log given the meal id
    #
    # @param meal_id [Integer] The ID of the meal

    def meal(meal_id)
      get("user/#{user_id}/meals/#{meal_id}.json")
    end

    # Creates a meal with the given food
    #
    # @param body [Hash] The POST request body

    def create_meal(body)
      post("user/#{user_id}/meals.json", body)
    end

    # Updates an existing meal with the contents of the request
    #
    # @param meal_id [Integer] The ID of the meal
    # @param body [Hash] The POST request body

    def update_meal(meal_id, body)
      post("user/#{user_id}/meals/#{meal_id}.json", body)
    end

    # Deletes an existing meal of the given meal ID
    #
    # @param meal_id [Integer] The ID of the meal

    def delete_meal(meal_id)
      delete("user/#{user_id}/meals/#{meal_id}.json")
    end
  end
end
