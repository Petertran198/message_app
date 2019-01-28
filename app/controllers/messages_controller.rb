class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save 
      ActionCable.server.broadcast "chatroom_channel",
                                                      mod_message: message_render(message) #You can call mod_message anything it is only use so u can recieve data in chatroom.coffee
                                                     
    end
  end






private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end



end