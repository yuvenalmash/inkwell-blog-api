class Api::V1::MessagesController < ApplicationController
  before_action :set_user, only: %i[index create update destroy]

   def index
    @messages = Message.where(sender_id: @user.id).or(Message.where(recipient_id: @user.id))
    render json: @messages, include: { sender: { only: %i[username avatar] }, recipient: { only: %i[username avatar] } }
   end

    def create
      message = Message.new(message_params)
      message.sender = @user
      if message.save
        render json: message, status: :created
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      # can only update the read attribute
      message = Message.find(params[:id])
      if @user == message.recipient
        if message.update(read: true)
          render json: message, status: :reset_content
        else
          render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
      end
    end

    def destroy
      message = Message.find(params[:id])
      if @user == message.sender
        if message.destroy
          render json: message, status: :no_content
        else
          render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
      end
    end

   private

   def set_user
     @user = User.find(params[:user_id])
   end

    def message_params
      params.require(:message).permit(:recipient_id, :subject, :content)
    end
end
