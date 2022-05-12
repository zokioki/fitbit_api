module FitbitAPI
  class Client
    # Retrieves a list of meals created by the user from their food log

    def meals
      get("user/#{user_id}/meals.json")
    end

    # Retrieves a single meal created by the user from their food log given the meal id
    #
    # @params meal_id [Integer] The ID of the meal

    def meal(meal_id)
      get("user/#{user_id}/meals/#{meal_id}.json")
    end

    # Creates a meal with the given food
    #
    # @params body [Hash] The POST request body

    def create_meal(body)
      post("user/#{user_id}/meals.json", body)
    end

    # Updates an existing meal with the contents of the request
    #
    # @params meal_id [Integer] The ID of the meal
    # @params body [Hash] The POST request body

    def update_meal(meal_id, body)
      post("user/#{user_id}/meals/#{meal_id}.json", body)
    end

    # Deletes an existing meal of the given meal ID
    #
    # @params meal_id [Integer] The ID of the meal

    def delete_meal(meal_id)
      delete("user/#{user_id}/meals/#{meal_id}.json")
    end
  end
end
