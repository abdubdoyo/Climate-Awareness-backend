class Api::V1::ChatbotController < ApplicationController
    require 'httparty'

    def ask
      user_message = params[:message]

      response = HTTParty.post(
        "https://api.openai.com/v1/chat/completions",
        headers:{
          "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}",
          "Content-Type" => "application/json",
        },
        body: {
          model: "gpt-4",
          messages: [{ role: "user", content: user_message }]
        }.to_json
      )
      render json: { reply: response.parsed_response["choices"][0]["message"]["content"] }
    end
end