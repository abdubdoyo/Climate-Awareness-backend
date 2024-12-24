class Api::V1::ChatbotController < ApplicationController
    require 'httparty'

    def ask
      user_message = params[:message]

      if user_message.blank?
        render json: { error: 'Message cannot be blank' }, status: :unprocessable_entity and return
      end

      begin
        response = HTTParty.post(
          "https://api.openai.com/v1/chat/completions",
          headers:{
            "Authorization" => "Bearer #{ENV['REACT_APP_OPENAI_API_KEY']}",
            "Content-Type" => "application/json",
          },
          body: {
            model: "gpt-4o-mini",
            messages: [{ role: "user", content: user_message }]
          }.to_json
        )

        if response.success?
          bot_reply = response.parsed_response.dig("choices", 0, "message", "content")
          render json: { reply: bot_reply }
        else
          Rails.logger.error("OpenAI API Error: #{response.parsed_response}")
          render json: { error: 'Failed to fetch response from OpenAI' }, status: :bad_request
        end
      rescue StandardError => e
        Rails.logger.error("ChatbotController Error: #{e.message}")
        render json: { error: 'An unexpected error occurred' }, status: :internal_server_error
      end
    end
end